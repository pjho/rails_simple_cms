class Cms::SettingsController < CmsController

  def index
    # A bit of a hack here since get_all only returns what's in the database not default settings
    @settings = ( set = Settings.get_all!('site.') ) ? set : load_site_defaults
    @social = ( soc = Settings.get_all!('social.') ) ? soc : load_social_defaults
  end

  def update
    allowed = allowed_keys
    params['settings'].each_pair do |setting, value|
      eval("Settings['#{setting}'] = value") if allowed.include? setting
    end
    redirect_to :back, :notice => 'Updated Successfully' 
  end

  def menu
    @sidebar = Settings['menus.sidebar']
    @footer = Settings['menus.footer']
  end

private
  
  def allowed_keys
    ['site.default_page_title', 'site.site_description', 'site.copyright_text', 'social.twitter',
      'social.github', 'social.dribbble', 'social.linkedin', 'social.facebook', 'social.stackexchange',
      'social.email', 'menus.sidebar', 'menus.footer']
  end
  
  def load_site_defaults
    { 'site.default_page_title' => Settings['site.default_page_title'],
      'site.site_description' => Settings["site.site_description"],
      'site.copyright_text' => Settings["site.copyright_text"] }
  end

  def load_social_defaults
   { 'social.twitter' => Settings['social.twitter'], 'social.github' => Settings["social.github"],
     'social.dribbble' => Settings['social.dribbble'], 'social.linkedin' => Settings["social.linkedin"],
     'social.facebook' => Settings['social.facebook'], 'social.stack_exchange' => Settings["social.stack_exchange"],
     'social.email' => Settings['social.email'] }
  end

end