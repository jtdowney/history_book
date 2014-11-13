module HistoryBook
  module Sequel
    class Store
      def initialize(db, events_table)
        @db = db
        @events_table = events_table

        _create_events_table
      end

      def load_events(id, options = {})
        options = {:from => 1, :to => nil}.merge(options)
        from, to = options.values_at(:from, :to)

        rows = _load_rows(id, from, to)
        rows.map do |row|
          _transform_row(row)
        end
      end

      def store_events(id, new_events)
        @db.transaction do
          max_revision = _max_revision(id)

          new_events = Array(new_events)
          new_events.each do |new_event|
            max_revision += 1
            @db.from(@events_table).insert(
              :stream_id => id,
              :revision => max_revision,
              :timestamp => DateTime.now,
              :type => new_event.type.to_s,
              :data => _encode_data(new_event.data)
            )
          end
        end
      end

      def _create_events_table
        @db.create_table?(@events_table) do
          primary_key :id
          String :stream_id
          Integer :revision
          DateTime :timestamp
          String :type
          File :data
          index [:stream_id, :revision], :unique => true
        end
      end

      def _load_rows(id, from, to)
        rows = @db.
          from(@events_table).
          where(:stream_id => id).
          where('revision >= ?', from)

        if to
          rows = rows.where('revision <= ?', to)
        end

        rows
      end

      def _max_revision(id)
        @db.from(@events_table).where(:stream_id => id).max(:revision) || 0
      end

      def _encode_data(data)
        io = StringIO.new
        writer = Transit::Writer.new(:json, io)
        writer.write(data)
        io.rewind
        io.read
      end

      def _decode_data(data)
        io = StringIO.new(data)
        reader = Transit::Reader.new(:json, io)
        reader.read
      end

      def _transform_row(row)
        type = row[:type].to_sym
        data = _decode_data(row[:data])
        HistoryBook::Event.new(type, data)
      end
    end
  end
end
