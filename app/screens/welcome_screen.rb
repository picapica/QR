class WelcomeScreen < PM::Screen
  title "欢迎"._

  def on_load
    set_attributes self.view, backgroundColor: UIColor.grayColor
    
    add UILabel.alloc.initWithFrame(self.view.frame, textContainer: nil),
    text: "Welcome to #{App.name}!",
    resize: [ :left, :right, :top ],
    background_color: UIColor.clearColor,
    text_color: UIColor.whiteColor,
    shadow_color: UIColor.blackColor,
    number_of_lines: 0,
    text_alignment: UITextAlignmentCenter,
    font: UIFont.boldSystemFontOfSize(18.0)

  end

  def on_appear
    sleep 1.414
    open_tab_bar ScanScreen.new(nav_bar: true)

  end

end