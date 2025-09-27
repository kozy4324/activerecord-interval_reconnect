# frozen_string_literal: true

require "active_support"

require_relative "interval_reconnect/version"

ActiveSupport.on_load(:active_record) do
  ActiveRecord::ConnectionAdapters::AbstractAdapter.set_callback(:checkout, :after) do
    reconnection_interval = @config[:reconnection_interval]
    next unless reconnection_interval

    @window_start_at ||= Process.clock_gettime(Process::CLOCK_MONOTONIC)
    if (Process.clock_gettime(Process::CLOCK_MONOTONIC) - @window_start_at) > reconnection_interval
      reconnect!
      @window_start_at = Process.clock_gettime(Process::CLOCK_MONOTONIC)
    end
  end
end
