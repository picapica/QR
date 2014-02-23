class SettingsScreen < PM::Screen
  title "设置"._
  tab_bar_item icon: "icons/24/basic-settings-icon.png", title: "设置"._

  def on_load
    set_attributes self.view, backgroundColor: UIColor.grayColor
    
    add UILabel.alloc.initWithFrame(self.view.frame, textContainer: nil),
    text: "设置 #{App.name}!",
    resize: [ :left, :right, :top ],
    background_color: UIColor.clearColor,
    text_color: UIColor.whiteColor,
    shadow_color: UIColor.blackColor,
    number_of_lines: 0,
    text_alignment: UITextAlignmentCenter,
    font: UIFont.boldSystemFontOfSize(18.0)

  end

  def on_appear
  end

end