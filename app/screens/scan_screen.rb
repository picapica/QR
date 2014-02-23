class ScanScreen < PM::Screen
  title "扫描"._

  def on_load
    set_nav_bar_button :right, title: "返回"._, action: :close

    @capture_is_set_up ||= begin
      setupCapture

      true
    end
  end

  def setupCapture
    @session = AVCaptureSession.alloc.init
    @session.sessionPreset = AVCaptureSessionPresetHigh

    @device = AVCaptureDevice.defaultDeviceWithMediaType AVMediaTypeVideo
    @error = Pointer.new('@')
    @input = AVCaptureDeviceInput.deviceInputWithDevice @device, error: @error

    @previewLayer = AVCaptureVideoPreviewLayer.alloc.initWithSession(@session)
    @previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
    layerRect = self.view.layer.bounds
    @previewLayer.bounds = layerRect
    @previewLayer.setPosition(CGPointMake(CGRectGetMidX(layerRect), CGRectGetMidY(layerRect)))
    self.view.layer.addSublayer(@previewLayer)

    @queue = Dispatch::Queue.new('camQueue')
    @output = AVCaptureMetadataOutput.alloc.init
    @output.setMetadataObjectsDelegate self, queue: @queue.dispatch_object

    @session.addInput @input
    @session.addOutput @output
    @output.metadataObjectTypes = [ AVMetadataObjectTypeQRCode ]

    @session.startRunning

  end

  def captureOutput(captureOutput, didOutputMetadataObjects: metadataObjects, fromConnection: connection)
    @alertActions = ["取消"._, "查看"._]

    Dispatch::Queue.main.async do
      code = metadataObjects[0]

      if code and code = code.stringValue
        @session.stopRunning
        alert = UIAlertView.new
        alert.message = code
        @alertActions.each do |action_str|
          alert.addButtonWithTitle action_str
        end
        alert.delegate = self
        alert.show
      end
      true
    end
  end
    
  def alertView(alert, clickedButtonAtIndex:index)
    NSLog "index:#{index}:#{alert.message}"
    case @alertActions[index]
    when "查看"._
      BW::HTTP.get("http://assets.dajie-inc.com/assets/submit?seq=%s" % [alert.message]) do |response|
        if response and response.body
          @assetInfo.text = response.body.to_str
          alert = UIAlertView.new
          alert.message = response.body.to_str
          alert.addButtonWithTitle "好的"._
          alert.delegate = self
          alert.show
        else
          NSLog 'response empty'
          @session.startRunning
        end
      end
    when "好的"._
      @session.startRunning
    when "取消"._
      NSLog 'Cancel'
      @session.startRunning
    else
      NSLog 'unknown'
      @session.startRunning
    end
  end
end