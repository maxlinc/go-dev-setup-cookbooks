## openbox

cookbook_file "/home/vagrant/.xinitrc" do
  owner "vagrant"
  group "vagrant"
  source "xinitrc"
  backup false
  mode "0664"
end

cookbook_file "/home/vagrant/.bash_profile" do
  owner "vagrant"
  group "vagrant"
  source "bash_profile"
  backup false
  mode "0664"
end

cookbook_file "/home/vagrant/cairo-dock_configuration.zip" do
  owner "vagrant"
  group "vagrant"
  source "cairo-dock_configuration.zip"
  backup false
  mode "0664"
end

["/home/vagrant/.config/", "/home/vagrant/.config/openbox/"].each do |dir|
  directory dir do
    owner "vagrant"
    group "vagrant"
    mode 00755
    recursive true
    action :create
  end
end

["/home/vagrant/.config/cairo-dock"].each do |dir|
  directory dir do
    owner "vagrant"
    group "vagrant"
    mode 00755
    recursive true
    action :create
  end
end

script "install_openbox" do
  interpreter "bash"
  user "root"
  cwd "/tmp/"
  code <<-EOH
  sudo apt-get -y --no-install-recommends install xserver-xorg xinit openbox xterm

  sudo apt-get install -y cairo-dock

  cp -R /etc/xdg/openbox/* /home/vagrant/.config/openbox
  unzip /home/vagrant/cairo-dock_configuration.zip -d /home/vagrant/.config/cairo-dock 
  EOH
end

cookbook_file "/home/vagrant/.config/openbox/menu.xml" do
  owner "vagrant"
  group "vagrant"
  source "menu.xml"
  backup false
  mode "0664"
end
