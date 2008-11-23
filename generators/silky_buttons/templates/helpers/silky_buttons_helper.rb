module SilkyButtonsHelper

  def silk_image( img, options={} )
    image_tag "/images/silk/icons/#{img}", options
  end

  def submit_resource_button(text, options={})
    options[:text]      = text
    options[:class]     ||= ''
    options[:id]        ||= ''
    options[:type]      ||= "submit"
    options[:icon]      ||= 'tick.png'
    unless options[:icon].blank?
      options[:icon] =  silk_image(options[:icon])
      options[:text] = "#{options[:icon]} #{options[:text]}"
    end
    link_to_options = {}
    link_to_options.merge!({ :class => "button #{options[:class]}" })
    link_to_options.merge!({ :id => options[:id] }) unless options[:id].blank?
    link_to_options.merge!({ :type => options[:type] })
    content_tag(:button, options[:text], link_to_options)
  end
  alias_method :submit_button, :submit_resource_button

  def show_resource_button(resource, options={})
    options[:icon]  ||= "eye.png"
    options[:text]  ||= "Show #{resource.class.to_s.humanize}"
    options[:path]  ||= polymorphic_path(resource)
    resource_button(resource, options)
  end
  alias_method :show_button, :show_resource_button

  def new_resource_button(resource, options={})
    options[:class]   = "positive"
    options[:icon]  ||= "add.png"
    options[:text]  ||= "Create #{resource.class.to_s.humanize}"
    options[:path]  ||= new_polymorphic_path(resource)
    resource_button(resource, options)
  end
  alias_method :new_button, :new_resource_button

  def edit_resource_button(resource, options={})
    options[:icon]  ||= "pencil.png"
    options[:path]  ||= edit_polymorphic_path(resource)
    options[:text]  ||= "Edit #{resource.class.to_s.humanize}"
    resource_button(resource, options)
  end
  alias_method :edit_button, :edit_resource_button

  def destroy_resource_button(resource, options={})
    options[:class]   = "negative"
    options[:icon]    ||= "delete.png"
    options[:path]    ||= polymorphic_path(resource)
    options[:text]    ||= "Delete #{resource.class.to_s.humanize}"
    options[:method]  ||= :delete
    options[:confirm] ||= "Are you sure?"
    resource_button(resource, options)
  end
  alias_method :destroy_button, :destroy_resource_button

  def resource_button(resource, options={})
    options[:confirm]     ||= nil
    options[:method]      ||= nil
    options[:icon]        ||= ''
    options[:text]        ||= "#{resource.class.to_s.humanize}"
    options[:path]        ||= polymorphic_path(resource)
    options[:class]       ||= ''
    unless options[:icon].blank?
      options[:icon] = silk_image(options[:icon])
      options[:text] = "#{options[:icon]} #{options[:text]}"
    end
    link_to_options = {}
    link_to_options.merge!({ :class => "button #{options[:class]}" })
    link_to_options.merge!({ :method => options[:method] }) unless options[:method].blank?
    link_to_options.merge!({ :confirm => options[:confirm] }) unless options[:confirm].blank?
    # content_tag :div, :class => "clearfix" do
      link_to options[:text], options[:path], link_to_options
    # end
  end
  
end
