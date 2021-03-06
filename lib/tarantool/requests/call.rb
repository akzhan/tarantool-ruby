module Tarantool
  module Requests
    class Call < Request
      request_type :call

      attr_reader :flags, :proc_name, :tuple
      def parse_args
        @flags = params[:return_tuple] ? 1 : 0
        @proc_name = params[:proc_name]
        @tuple = params[:args] || []
      end

      def make_body
        [flags].pack('L') +
        self.class.pack_field(proc_name) +
        self.class.pack_tuple(*tuple)
      end
    end
  end
end