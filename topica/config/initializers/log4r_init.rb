#log4r requirements
require 'log4r'
require 'log4r/yamlconfigurator'
require 'log4r/outputter/datefileoutputter'
require 'log4r/outputter/fileoutputter'
require 'log4r/formatter/formatter'
include Log4r

# assign log4r's logger as rails' logger.
log4r_config= YAML.load_file(File.join(File.dirname(__FILE__),"log4r.yml"))
log_cfg = YamlConfigurator
log_cfg["ENV"] = Rails.env 
#log_cfg["EC2_INSTANCE"] = ENV["EC2_INSTANCE"].nil? ? `hostname`.to_s.gsub(/\n$/, "") : ENV["EC2_INSTANCE"] 
log_cfg["APPNAME"] = Rails.application.class.parent_name
log_cfg.decode_yaml( log4r_config['log4r_config'] )

# disable standard Rails logging
Rails.logger.level = 5
Topica::Application.config.log_level = :unknown

Topica::Application.config.logger = Log4r::Logger['rails']
ActiveRecord::Base.logger = Log4r::Logger['rails'] 
ActionController::Base.logger = Log4r::Logger['rails']


