=begin
from the blog post http://blog.mmlac.com/log4r-for-rails/#Rails

ActiveSupport::Notifications which allows subscribing to many events that 
happen throughout the lifecycle of a request and also supports sending 
your own notifications. The most important type of notification for logging is 
process_action.action_controller . It contains the information about the processing 
of the request, the time it took and every parameter associated with the request.

The following example will output the most important facts of a request at
the INFO log level and WARN on requests that take longer than 200ms or return 
a http status code different from 200 or 500. An ERROR will be logged when an 
exception is thrown or the request returned a status of 500. The DEBUG level 
will print the timings of view renderings and database calls and the parameters 
are printed at the PARAMS log level.
=end
def time_in_ms(start, finish)
  return ( ((finish - start).to_f * 100000).round / 100.0 )
end

def time_in_ms_s(start, finish)
  return ( ((finish - start).to_f * 100000).round / 100.0 ).to_s
end


ActiveSupport::Notifications.subscribe("process_action.action_controller") do |name, start, finish, id, payload|

  logger = Log4r::Logger['rails']

  controller_format = "@method @status @path @durationms"

  if !payload[:exception].nil? || payload[:status] == 500
    #["process_action.action_controller", 0.033505, "b4ebe16ef3da4c5eb902", {:controller=>"MongotestController", :action=>"index", :params=>{"action"=>"index", "controller"=>"mongotest"}, :format=>:html, :method=>"GET", :path=>"/mongotest", :exception=>["Mongoid::Errors::DocumentNotFound", "\nPro   ...  "]}
    logger.error { 
      message = controller_format.clone
      message.sub!(/@status/, payload[:status].to_s)
      message.sub!(/@method/, payload[:method])
      message.sub!(/@path/, payload[:path])
      message.sub!(/@duration/, time_in_ms_s(start,finish))
      message += " EXCEPTION: #{payload[:exception]}"
      message
    }
  end

  if payload[:status] != 200 && payload[:status] != 500 && payload[:exception].nil?
    logger.warn { 
      message = controller_format.clone
      message.sub!(/@status/, payload[:status].to_s)
      message.sub!(/@method/, payload[:method])
      message.sub!(/@path/, payload[:path])
      message.sub!(/@duration/, time_in_ms_s(start,finish))
      message += " EXCEPTION: #{payload[:exception]}"
      message
    }
  end

  if payload[:status] == 200 && time_in_ms(start,finish) >= 500
    logger.warn { 
      message = controller_format.clone
      message.sub!(/@status/, payload[:status].to_s)
      message.sub!(/@method/, payload[:method])
      message.sub!(/@path/, payload[:path])
      message.sub!(/@duration/, time_in_ms_s(start,finish))
      message
    }
  end

  if payload[:status] == 200 && time_in_ms(start,finish) < 2000
    logger.info { 
      message = controller_format.clone
      message.sub!(/@status/, payload[:status].to_s)
      message.sub!(/@method/, payload[:method])
      message.sub!(/@path/, payload[:path])
      message.sub!(/@duration/, time_in_ms_s(start,finish))
      message
    }
  end

  logger.params { "PARAMS: #{payload[:params].to_json }" }
  logger.debug {
    db = (payload[:db_runtime] * 100).round/100.0 rescue "-"
    view = (payload[:view_runtime] * 100).round/100.0 rescue "-"
    "TIMING[ms]: sum:#{time_in_ms_s(start,finish)} db:#{db} view:#{view}" 
  }

end
