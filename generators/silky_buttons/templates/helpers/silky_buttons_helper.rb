module SilkyButtonsHelper

  def silk_image( img, options={} )
    image_tag "/images/silk/icons/#{img}", options
  end

  def submit_button(text, options={})
    options[:text]      = text
    options[:type]      = "submit"
    options[:icon]      ||= "tick.png"
    unless options[:icon].blank?
      options[:icon] =  silk_image(options[:icon])
      options[:text] = "#{options[:icon]} #{options[:text]}"
    end
    options.merge!({ :class => "button #{options[:class]}" })
    content_tag :button, options[:text].html_safe, options.delete_if { |k, v| [:icon, :text].include? k }
  end

  def show_button(resource, options={})
    options[:icon]  ||= "eye.png"
    options[:text]  ||= "#{t('silky_buttons.show')} #{resource.class.model_name.human}"
    options[:path]  ||= polymorphic_path(resource)
    resource_button(resource, options)
  end

  def new_button(resource_class, options={})
    options[:class]   = "positive #{options[:class]}"
    options[:icon]  ||= "add.png"
    options[:text]  ||= "#{t('silky_buttons.new')} #{resource_class.model_name.human}"
    options[:path]  ||= new_polymorphic_path(resource_class)
    resource_button(resource_class, options)
  end

  def edit_button(resource, options={})
    options[:icon]  ||= "pencil.png"
    options[:text]  ||= "#{t('silky_buttons.edit')} #{resource.class.model_name.human}"
    options[:path]  ||= edit_polymorphic_path(resource)
    resource_button(resource, options)
  end

  def destroy_button(resource, options={})
    options[:class]   = "negative #{options[:class]}"
    options[:method]  ||= :delete
    options[:confirm] ||= "#{t('silky_buttons.destroy.button')}"
    options[:icon]    ||= "delete.png"
    options[:text]    ||= "#{t('silky_buttons.destroy.confirm')} #{resource.class.model_name.human}"
    options[:path]    ||= polymorphic_path(resource)
    resource_button(resource, options)
  end

  def index_button(resource, options={})
    options[:icon]  ||= "house.png"
    options[:text]  ||= "#{t('silky_buttons.index')}"
    options[:path]  ||= polymorphic_path(resource.class)
    resource_button(resource, options)
  end

  def back_button(resource, options={})
    options[:icon]  ||= "arrow_left.png"
    options[:text]  ||= "#{t('silky_buttons.back')}"
    options[:path]  ||= url_for(:back)
    resource_button(resource, options)
  end

  def resource_button(resource, options={})
    options[:text]        ||= resource.class.model_name.human
    options[:path]        ||= polymorphic_path(resource)
    unless options[:icon].blank?
      options[:icon] = silk_image(options[:icon])
      options[:text] = "#{options[:icon]} #{options[:text]}"
    end
    options.merge!({ :class => "button #{options[:class]}" })
    link_to options[:text].html_safe, options[:path], options.delete_if { |k, v| [:icon, :text, :path].include? k }
  end
  
end
