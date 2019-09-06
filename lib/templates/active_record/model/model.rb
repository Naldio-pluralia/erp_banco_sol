<% module_namespacing do -%>
class <%= class_name %> < <%= parent_class_name.classify %>
  <% attributes.select(&:reference?).each do |attribute| -%>
    belongs_to :<%= attribute.name %><%= ', polymorphic: true' if attribute.polymorphic? %><%= ', required: true' if attribute.required? %>
  <% end -%>
  <% attributes.select(&:token?).each do |attribute| -%>
    has_secure_token<% if attribute.name != "token" %> :<%= attribute.name %><% end %>
  <% end -%>
  <% if attributes.any?(&:password_digest?) -%>
    has_secure_password
  <% end -%>
  <%# TODO Comentar aqui%>
  <% attributes.select{|attribute| attribute.type.eql? :enum}.each do |attribute| %>
    enum <%= attribute.name%>: {default_key: 0, key1: 1, key2: 2, so_on: 3}
  <% end -%>
  <%- attributes_to_validate = attributes.select{|attribute| attribute.type == :enum || attribute.reference?}.map{|attribute|":#{attribute.name}"} -%>
  <%if attributes_to_validate.any?-%>
    validates_presence_of <%= attributes_to_validate.join(", ") %>
  <%end-%>
end
<% end -%>
    