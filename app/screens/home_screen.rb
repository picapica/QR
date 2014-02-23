class HomeScreen < PM::TableScreen
  title "首页"._
  tab_bar_item icon: "icons/24/basic-home-icon.png", title: "首页"._

  def on_load
    set_attributes self.view, backgroundColor: UIColor.whiteColor

  end

  def on_appear

  end

  def table_data
    [{
      #title: "操作"._,
      cells: [
        { title: "扫描"._, action: :go_to_scan, arguments: {}},
        { title: "历史记录"._, action: :go_to_scan_history, arguments: {}}
      ]
    }]
  end

  def go_to_scan
    @scan_screen ||= begin
      ScanScreen.new(nav_bar: true)
    end

    open @scan_screen, hide_tab_bar: true, modal: true
  end

  def go_to_scan_history

  end

end