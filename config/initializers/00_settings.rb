class Settings < Settingslogic
  source "#{Rails.root}/config/config.yml"
  namespace Rails.env

  # TODO: Mix in all of the ENV variables for secrets, etc.

  Settings['redis']        ||= Settingslogic.new({})
  Settings['redis']['url'] ||= Settingslogic.new({})

  Settings['sessions']                 ||= Settingslogic.new({})
  Settings['sessions']['key']          ||= '_cable-chat-session'
  Settings['sessions']['key_prefix']   ||= 'cable-chat:session:'
  Settings['sessions']['expire_after'] ||= 2.days

  Settings['cache']              ||= Settingslogic.new({})
  Settings['cache']['url']       ||= 'redis://:@localhost:6379/0'
  Settings['cache']['db']        ||= URI.parse(Settings['cache']['url']).path.gsub('/', '')
  Settings['cache']['password']  ||= URI.parse(Settings['cache']['url']).password
  Settings['cache']['host']      ||= URI.parse(Settings['cache']['url']).host
  Settings['cache']['port']      ||= URI.parse(Settings['cache']['url']).port
  Settings['cache']['namespace'] ||= "image_pipeline_#{Rails.env}"

  Settings['app']                  ||= Settingslogic.new({})
  Settings['app']['front_end_url'] ||= "http://localhost:3005"
  Settings['app']['api_url']       ||= "https://websocket.roosterteeth.com"

end
