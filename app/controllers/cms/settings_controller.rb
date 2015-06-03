class Cms::SettingsController < CmsController

  def index
    # @settings = Settings.thing_scoped.all
    @settings = Settings.get_all('site.')
    @social = Settings.get_all('social.')
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
    [ 
      'site.default_page_title',
      'site.site_description',
      'site.copyright_text',
      'social.twitter',
      'social.github',
      'social.dribble',
      'social.linkedin',
      'social.facebook',
      'social.stackexchange',
      'social.email',
      'menus.sidebar',
      'menus.footer'
    ]
  end

end
