ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content title: proc{ I18n.t("active_admin.dashboard") } do
    div class: "blank_slate_container", id: "dashboard_default_message" do
      span class: "blank_slate" do
        span I18n.t("active_admin.dashboard_welcome.welcome")
        small I18n.t("active_admin.dashboard_welcome.call_to_action")
      end
    end

    # Here is an example of a simple dashboard with columns and panels.
    #
    # columns do
    #   column do
    #     panel "Recent Posts" do
    #       ul do
    #         Post.recent(5).map do |post|
    #           li link_to(post.title, admin_post_path(post))
    #         end
    #       end
    #     end
    #   end

    #   column do
    #     panel "Info" do
    #       para "Welcome to ActiveAdmin."
    #     end
    #   end
    # end

columns do
  column  do
    panel 'tiendas' do
      span "Numero De Tiendas: #{Shop.count}"
    end
  end
  column do
    panel 'productos' do
      span "Numero de Productos Total: #{Product.count}"
    end
  end
  column do
    panel 'usuarios' do
      span "Numero de Usuarios: #{User.count}"
    end
  end
 end

 panel 'Ordenes Por Dia' do 
  render  'partial/linechart'
 end

 panel 'Usuarios Creados Por dia' do 
  render  'partial/barchart'
 end

end
end
