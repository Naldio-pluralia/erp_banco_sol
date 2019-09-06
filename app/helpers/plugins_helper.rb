module PluginsHelper
  
  # Draws the plugins menu
  # root -> a plugin object which is the root
  # plugins -> a colection of plugins grouped_by parent_idlike {1: [Plugin.instance, Plugin.instance, Plugin.instance, 7: [Plugin.instance, Plugin.instance, Plugin.instance]}
    # where the key is the parent id
  # This allows us to get the children with plugins[root.id] instead of making a Activerecord Query again
  def side_menu(root, plugins = {})
    return unless root.is_active
    children = plugins[root.id]
    if children.present?
      sn_item(t("side_menu.#{root.description.downcase}", default: root.description.downcase.to_sym), root.icon) do
        children.sort_by{|c| c.order}.each{ |child| concat(side_menu(child, plugins))}
      end
    else
      options = {}
      options = {href: "#{send(root.url)}"} if root.url.present? && !root.url.include?(",")
      options = {href: "#{send(root.url.split(",")[0], anchor: root.url.split(",")[1])}"} if root.url.present? && root.url.include?(",")
      options[:if_can] = {root.if_can.split(',')[0].to_sym => root.if_can.split(',')[1].gsub('nextsgad/', '').classify.constantize} if root.if_can.present?
      sn_item(t("side_menu.#{root.description.downcase}", default: root.description.downcase.to_sym), root.icon, options) unless root.url.blank?
    end
  end
end
