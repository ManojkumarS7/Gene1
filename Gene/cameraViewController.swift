//
//  ViewController.swift
//  Gene
//
//  Created by manoj on 15/12/23.
//


import UIKit
import AVFoundation
import Photos
import CoreMotion
import CoreImage



class cameraViewController : UIViewController,AVCapturePhotoCaptureDelegate,UIGestureRecognizerDelegate{
 
    
    
    
    var cameraView: UIView!
    var captureButton: UIButton!
    var cameraSwitchButton: UIButton!
    var flashModeButton: UIButton!
    var backCamera : AVCaptureDevice!
    var frontCamera : AVCaptureDevice!
    var currentCamera: AVCaptureDevice?
    var ultraWideCamera: AVCaptureDevice!
    var captureSession = AVCaptureSession()
    var stillImageOutput: AVCapturePhotoOutput!
    var previewLayer: AVCaptureVideoPreviewLayer!
    var positionString = String()
    var imageView : UIImageView!
    var currentZoomFactor: CGFloat = 1.0
    var maxZoomFactor: CGFloat = 5.0
    var zoomStep: CGFloat = 1.0
    var currentFlashMode : String! // AVCaptureDevice.FlashMode = .auto // set flash mode on auto
    var isFlashOn: Bool = false
    var exposurePoint = CGPoint(x: 0.5, y: 0.5)
    var focusPoint = CGPoint(x: 0.5, y: 0.5)
    var boxView = UIView()
    var exposureSlider: UISlider!
    var currentExposureBias: Float = 0.0
    var currentFocusLevel: Float = 0.0
    var currentExposureValue: Float = 0.5
    var motionManager: CMMotionManager!
    var yawAngle: Double = 0.0
    var aspectControll : UISegmentedControl? // segment controll for select a aspect ratio
    var currentAspectRatio : AVCaptureSession.Preset = .photo// set default aspet ratio on capture session
    var selectedAspectRatio: String = "4:3"
    var selectedlens : String = "1x"
    var timerButton : UIButton!
    var timerDuration: TimeInterval = 0
    var timerLabel: UILabel!
    var timer : Timer?
    
    var styleButton : UIButton!
    var levelView: UIView!
    var Currenttolerance : CGFloat = 1.0
    var straightAngle: CGFloat =  0.0
    
    var wideControll : UISegmentedControl!
    var switchButton : UIButton!
    var homeButton : UIButton!
    
    var capturedImage: UIImage?
    var sliderHiderTimer: Timer!
    var finalAngle : Double = 0.0
    var portraitEffectButton : UIButton!
    var isPortraitEffectEnabled: Bool = true
    
   var finalAngleFromPicture : Double = 0.0
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        setupCameraView()
        setupCamera()
        setupButtons()
        //  setupBoxView()
        // setupExposureSlider()
        setupGestures()
        
        setupLevelView()
        setupBoxAndSliderView()
        
        setAspectRatio(selectedAspectRatio)
        
        setupMotionManager(finalAngle: finalAngle)
        setCameralens(selectedlens)
        
        //    if let currentCamera = currentCamera {
        //        switchCamera(to: backCamera)
        //    }
        
       
    }
  
    //it was using for hide status bar on display eg:battery status,singnal
    override  var prefersStatusBarHidden: Bool{
        return true
    }
 
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        coordinator.animate(alongsideTransition: { _ in
            self.previewLayer?.connection?.videoOrientation = self.currentVideoOrientation()
            self.previewLayer?.frame = self.cameraView.bounds
        }, completion: nil)
    }
    
    //
    //override func viewWillAppear(_ animated: Bool) {
    //     super.viewWillAppear(animated)
    //    captureSession.startRunning()
    //  }
    //
    //  override func viewWillDisappear(_ animated: Bool) {
    //      super.viewWillDisappear(animated)
    //    captureSession.stopRunning()
    //  }
    
    
    func setupCameraView() {
        cameraView = UIView()
        cameraView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(cameraView)
        
        NSLayoutConstraint.activate([
            cameraView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            cameraView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            cameraView.topAnchor.constraint(equalTo: view.topAnchor),
            cameraView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        
    }
    
    
    func setupLevelView() {
        levelView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 2))
        levelView.backgroundColor = UIColor.red
        view.addSubview(levelView)
        levelView.translatesAutoresizingMaskIntoConstraints = false
        
        // Adding center constraints for the levelView
        NSLayoutConstraint.activate([
            levelView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            levelView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            levelView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1.0),
            levelView.heightAnchor.constraint(equalToConstant: 2)
        ])
        
        
    }
    
    
    
   
    
 
   func setupCamera() {
      captureSession = AVCaptureSession()
       
        let settings = AVCapturePhotoSettings()
        guard let backCamera = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back) else {
            print("Unable to access the back camera.")
            return
        }
       
       
           
           
           self.backCamera = backCamera
       
        guard let frontCamera = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front) else {
            print("Unable to access the front camera.")
            return
        }
        self.frontCamera = frontCamera

        guard let ultraWideCamera = AVCaptureDevice.default(.builtInUltraWideCamera, for: .video, position: .back) else {
            print("Unable to access the ultra-wide camera.")
            return
        }
        self.ultraWideCamera = ultraWideCamera
//
        guard let videoDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .unspecified)
        else { fatalError("No dual camera")}
//
      currentCamera = backCamera
//
        if let currentCamera = currentCamera {
            setupZoom(for: currentCamera)
            setupExposure(for: currentCamera)
        }
//
        do {
            let input = try AVCaptureDeviceInput(device: videoDevice)
            if captureSession.canAddInput(input) {
                captureSession.addInput(input)
            }

            //if isPortraitEffectEnabled {
            stillImageOutput = AVCapturePhotoOutput()
            if stillImageOutput.isPortraitEffectsMatteDeliverySupported {
                stillImageOutput.isPortraitEffectsMatteDeliveryEnabled = true
            } else {
            print("Depth delivery not supported")
            }
            if captureSession.canAddOutput(stillImageOutput!) {
                captureSession.addOutput(stillImageOutput!)
            }

            changeAspectRatio(preset: currentAspectRatio)
            previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            previewLayer.videoGravity = .resizeAspectFill
            previewLayer.frame = cameraView.bounds
            cameraView?.layer.addSublayer(previewLayer)

            DispatchQueue.global(qos: .userInitiated).async {
                self.captureSession.startRunning()
            }
        } catch {
            print("Error setting up camera: \(error)")
        }
       
       
       
  

       // Enable delivery of depth data after adding the output to the capture session.
      stillImageOutput.isDepthDataDeliveryEnabled = stillImageOutput.isDepthDataDeliverySupported
       self.captureSession.commitConfiguration()
    }
    

    func setCameralens(_ cameralens: String) {
        
        switch cameralens {
            
        case "1x" :
            if let backCamera = backCamera {
                
                switchCamera(to: backCamera)
            }
        case "0.5" :
            
            if let ultraWideCamera = ultraWideCamera {
                switchCamera(to: ultraWideCamera)
            }
        default:
            break
        }
        
        selectedlens  = cameralens
    }
    
    
    @objc func wideAngleValueChanged(_ sender: UISegmentedControl) {
        guard let angleControll = sender as? UISegmentedControl else {return}
        setCameralens(angleControll.titleForSegment(at: angleControll.selectedSegmentIndex) ?? "")
        
        
    }
    
    func switchCamera(to newCamera: AVCaptureDevice) {
        //captureSession = AVCaptureSession()
        captureSession.beginConfiguration()
        //  currentCamera = newCamera
        printCameraPosition()
        // Remove the existing input
        guard let currentInput = captureSession.inputs.first as? AVCaptureDeviceInput else { return }
        captureSession.removeInput(currentInput)
        
        // Add the input for the new camera
        do {
            let newInput = try AVCaptureDeviceInput(device: newCamera)
            if captureSession.canAddInput(newInput) {
                captureSession.addInput(newInput)
                currentCamera = newCamera
                
                /// setCameraDevice(newCamera)
                ///  changeAspectRatio(preset: currentAspectRatio)
            }
            
            else {
                print("Could not add input for the new camera.")
            }
        } catch {
            print("Error setting up the input for the new camera: \(error)")
        }
        
        
        captureSession.commitConfiguration()
    }
    
    func switchcamera(to cameraPosition: String) {
        
        //var positionString : String?
        
        switch cameraPosition.lowercased() {
        case "front":
            // FrontCamera()
            
            if let frontCamera = frontCamera {
                switchCamera(to: frontCamera)
             
            }
            wideControll?.isHidden = true
        case "back":
            //  Backcamera()
            
            if let backCamera = backCamera {
                
                switchCamera(to: backCamera)
              
            }
            wideControll?.isHidden = false
            // positionString = cameraPosition
            
        default:
            print("Invalid camera position: \(cameraPosition)")
        }
        
        positionString = cameraPosition
    }
    //
    func printCameraPosition() {
        guard let currentCamera = currentCamera else {
            print("Current camera is nil.")
            return
        }
        
        DispatchQueue.main.async { [self] in
            positionString = (currentCamera.position == .front) ? "Front" : "Back"
            print(positionString)
        }
        
        //        if currentCamera?.position == .front {
        //
        //
        //        }
        //
    }
    
    func updateCountdownLabel(_ secondsRemaining: Int) {
        DispatchQueue.main.async {
            self.timerLabel.text = "\(secondsRemaining)s"
        }
    }
    
    @objc func switchCameraButtonTapped(_ sender: UIButton) {
        
        // frontback("front")
        
        if let currentCamera = currentCamera {
            
            let newCamera = (currentCamera.position == .back) ? FrontCamera() : Backcamera()
            
            switchCamera(to: newCamera!)
            
            setupZoom(for: newCamera!)
            setupExposure(for: newCamera!)
            
            printCameraPosition()
        }
    }
    
    
    func FrontCamera() -> AVCaptureDevice? {
        
        return AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front)
        //wideControll.isHidden = true
    }
    
    func Backcamera() -> AVCaptureDevice? {
        
        return AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back)
    }
    
    
    
    func startCountdown(duration: TimeInterval) {
        timerDuration = duration
        var secondsRemaining = Int(duration)
        updateCountdownLabel(secondsRemaining)
        
        timer?.invalidate() // Invalidate any existing timers
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] timer in
            guard let self = self else { return }
            
            secondsRemaining -= 1
            updateCountdownLabel(secondsRemaining)
            
            if secondsRemaining <= 0 {
                timer.invalidate() // Stop the timer when the countdown is complete
                capturePhoto(self.timerButton) // Call your capture photo function here
            }
        }
    }
    
    // Function to stop the countdown timer
    func stopCountdown() {
        timer?.invalidate()
        timerLabel.text = " "
        timerDuration = 0
    }
    
    
    func setAspectRatio(_ aspectRatio: String) {
        
        let settings = AVCapturePhotoSettings()
        switch aspectRatio {
        case "4:3":
      changeAspectRatio(preset: .photo)
           // captureSession.sessionPreset = .photo
           // previewLayer.videoGravity = .resizeAspect
           
        case "16:9":
        changeAspectRatio(preset: .high)
           // captureSession.sessionPreset = .hd1920x1080
       // previewLayer.videoGravity = .resizeAspectFill
        case "1:1":
        setSquareAspectRatio()
            
            //captureSession.sessionPreset = .medium
          //  previewLayer.videoGravity = .resize
          
        default:
            break
        }
        
        selectedAspectRatio = aspectRatio
        
        // print(selectedAspectRatio)
    }
    
    @objc func segmentControllValueChanged(_ sender: UISegmentedControl) {
        guard let aspectControll = sender as? UISegmentedControl else { return }
        setAspectRatio(aspectControll.titleForSegment(at: aspectControll.selectedSegmentIndex) ?? "")
    }
    
    
    func changeAspectRatio(preset: AVCaptureSession.Preset) {
        
     //   let captureSession = AVCaptureSession()
        captureSession.beginConfiguration()
    
        captureSession.sessionPreset = preset
        captureSession.commitConfiguration()
        
        // Adjust the preview layer frame based on the new aspect ratio
        DispatchQueue.main.async {
            let previewLayerHeight: CGFloat
            let yOffset: CGFloat
            
            switch preset {
            case .photo: // 4:3
                previewLayerHeight = UIScreen.main.bounds.width * 4 / 3
                yOffset = (UIScreen.main.bounds.height - previewLayerHeight) / 2.0
                
            case .high: // 16:9
                previewLayerHeight = UIScreen.main.bounds.width * 16 / 9
                yOffset = (UIScreen.main.bounds.height - previewLayerHeight) / 2.0
                
            default:
                return
            }
            
            self.previewLayer?.frame = CGRect(x: 0, y: yOffset, width: UIScreen.main.bounds.width, height: previewLayerHeight)
        }
    }
    
   
    func setSquareAspectRatio() {
        captureSession.beginConfiguration()
        captureSession.sessionPreset = .photo
        captureSession.commitConfiguration()

       
        
        let previewLayerHeight = UIScreen.main.bounds.width
        let yOffset = (UIScreen.main.bounds.height - previewLayerHeight) / 2.0
        previewLayer?.frame = CGRect(x: 0, y: yOffset, width: UIScreen.main.bounds.width, height: previewLayerHeight)
    }
    
    
    @objc func timerButtonTapped(_ sender: UIButton) {
        // Toggle between off, 3s, and 10s timer modes
        switch timerDuration {
        case 0:
            timerDuration = 3
            sender.setTitle("3s", for: .normal)
            
        case 3:
            timerDuration = 10
            sender.setTitle("10s", for: .normal)
            
        case 10:
            timerDuration = 0
            sender.setTitle("", for: .normal)
            
        default:
            break
        }
        
    }
   
    func setupMotionManager(finalAngle: Double) {
        motionManager = CMMotionManager()
        //  motionManager.deviceMotionUpdateInterval = 0.1 // Adjust as needed
        
        if motionManager.isDeviceMotionAvailable {
            motionManager.startDeviceMotionUpdates(to: .main) { [weak self] (motion, error) in
                guard let self = self, let motion = motion else { return }
                
                // guard let motion = motionManager.deviceMotion else {return}
                let attitude = motion.attitude
                let roll = attitude.roll * 180.0
                
                
                
                
                //     let attitude = motion.attitude
                //   _ = attitude.roll * 180.0 / .pi
                _ = attitude.pitch * 180.0 / .pi
                _ = attitude.yaw * 180.0 / .pi
                
                // Calculate the angle between the device's top vector and a reference vector
                let referenceVector = CGVector(dx: 0, dy: -1) // For example, pointing upwards
                let deviceTopVector = CGVector(dx: CGFloat(cos(-attitude.yaw)), dy: CGFloat(sin(-attitude.yaw)))
                let angle = atan2(deviceTopVector.dy, deviceTopVector.dx) - atan2(referenceVector.dy, referenceVector.dx)
                
                // Convert the angle to the range of 0 to 359 degrees
                var rotationangleInDegrees = angle.truncatingRemainder(dividingBy: 360.0)
                if rotationangleInDegrees < 0 {
                    rotationangleInDegrees += 360.0
                }
                //   print(rotationangleInDegrees)
                //  self.updateLevelView()
                let rotationAngle = CGFloat(roll) * .pi / 180
                
                //  print("rotation \(rotationAngle)")
                
                // apply the rotation to the level view
                
                levelView?.transform = CGAffineTransform(rotationAngle: rotationAngle)
                
                
                
                let tolerance = Currenttolerance
                //self.finalAngle = rotationAngle
                //                if abs(roll - finalAngle) < tolerance   {
                //                    self.levelView?.backgroundColor = .green
                //                } else {
                //                    self.levelView?.backgroundColor = .red
                //                }
                
                //     let customDegreeValue = finalAngle
                
                
                //  let closestAngle = (roll.truncatingRemainder(dividingBy: 360.0) + 360.0).truncatingRemainder(dividingBy: 360.0)
                
                //   print("closet\(closestAngle)")
                
                if rotationAngle >= finalAngle - 0.1 && rotationAngle <= finalAngle + 0.1 {
                    
                    self.levelView?.backgroundColor = UIColor.green
                } else {
                    
                    self.levelView?.backgroundColor = UIColor.red
                }
                
                
                finalAngleFromPicture = rotationAngle
                
                //   print("finaal \(finalAngleFromPicture)")
                
                
                
            }
        } else {
            print("Device motion data is not available.")
        }
    }
  
    func currentVideoOrientation() -> AVCaptureVideoOrientation {
        let orientation = UIDevice.current.orientation
        switch orientation {
        case .portrait:
            return .portrait
        case .landscapeLeft:
            return .landscapeRight
        case .landscapeRight:
            return .landscapeLeft
        case .portraitUpsideDown:
            return .portraitUpsideDown
        default:
            return .portrait
        }
    }

    @objc func handlePinchGesture(_ recognizer: UIPinchGestureRecognizer) {
        guard let currentCamera = currentCamera else {
            print("No current camera available.")
            return
        }
        
        do {
            try currentCamera.lockForConfiguration()
            
            let zoomFactor = currentZoomFactor * recognizer.scale
            currentCamera.videoZoomFactor = max(1.0, min(zoomFactor, maxZoomFactor))
            
            currentCamera.unlockForConfiguration()
        } catch {
            print("Error adjusting zoom: \(error)")
        }
        
        if recognizer.state == .ended {
            updateZoomFactor(currentCamera.videoZoomFactor)
        }
    }
  
    @objc func capturePhoto(_ sender: UIButton) {
        // Check if the timer is set and start the countdown
        if timerDuration > 0 {
            // Disable the capture button during the countdown
            captureButton.isEnabled = false
            
            // Start the countdown timer
            var countdown = timerDuration
            Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
                countdown -= 1
                if countdown <= 0 {
                    // Capture the photo when the countdown reaches 0
                    self.captureImage()
                    timer.invalidate() // Stop the timer
                    // Reset the capture button title and enable the button
                    DispatchQueue.main.async {
                        // sender.setTitle("Capture", for: .normal)
                        self.captureButton.isEnabled = true
                        
                        self.timerLabel.isHidden = true
                    }
                } else {
                    // Update the capture button title to show the countdown
                    self.updateCountdownLabel(Int(countdown))
                }
            }
            // Display the countdown label
            // Start the timer immediately
            timerLabel.isHidden = false
            timer?.fire()
            
        }
        else {
            // If no timer is set, capture the photo immediately
            captureImage()
        }

        
    }
    func captureImage() {
        guard let stillImageOutput = stillImageOutput else {return}
       
        let photoSettings = AVCapturePhotoSettings()


        if isFlashOn {
           photoSettings.flashMode = .on
        } else {
            photoSettings.flashMode = .off
        }
        
        if stillImageOutput.isDepthDataDeliverySupported {
            photoSettings.isDepthDataDeliveryEnabled = true
        } else {
            photoSettings.isDepthDataDeliveryEnabled = false
        }
        stillImageOutput.capturePhoto(with: photoSettings, delegate: self)

    }

    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
           if let error = error {
               print("Error capturing photo: \(error)")
               return
           }
           
           guard let imageData = photo.fileDataRepresentation() else {
               print("Error getting photo data.")
               return
           }
           
           if let image = UIImage(data: imageData) {
               
            
        
             //  savePhotoToLibrary(image)
                  // uploadImage(image: image)
                   // capturedImage = image
                    
               let preview = photoPreviewViewController(frame: view.bounds)
               preview.imageView.image = image
               view.addSubview(preview)
                
               }
           
       }
       
            
            
            //func savePhotoToLibrary(_ image: UIImage) {
//
//        
//        
//        //        let currentAspectRatio: AVCaptureSession.Preset = captureSession.sessionPreset
//        //        let aspectRatioString = aspectRatioString(for: currentAspectRatio)
//        //        print("Aspect Ratio Used: \(aspectRatioString)")
//        //
//        
//     
//            
//            _ = AVCapturePhotoSettings()
//            PHPhotoLibrary.requestAuthorization { status in
//                guard status == .authorized else {
//                    print("Photo library access not authorized.")
//                    return
//                }
//                
//                PHPhotoLibrary.shared().performChanges {
//                    PHAssetChangeRequest.creationRequestForAsset(from: image)
//                } completionHandler: { [self] success, error in
//                    if let error = error {
//                        print("Error saving photo to library: \(error)")
//                    } else {
//                        print("Photo saved to library successfully.")
//                        print("Zoom Level: \(self.currentZoomFactor)")
//                        print("Exposure Value: \(currentExposureValue)")
//                        print("Focus Level: \(currentFocusLevel)")
//                        print ("Flash mode :\( isFlashOn)")
//                        print("Timer:\(timerDuration)")
//                        print("Aspect Ratio :\(selectedAspectRatio)")
//                        //print("Camera angle :\(selectedAngle)")
//                        print(selectedlens)
//                        //print(currentCamerPosition)
//                        print("currentCamera:\(positionString)")
//                        
//                        //   print(positionString!)
//                        // let finalAngle = (360.0 - yawAngle).truncatingRemainder(dividingBy: 360.0)
//                        //print("Final Angle Of Picture: \(roll)")
//                        
//                        
//                        
//                    }
//                }
//            }
//        }
// 
    @objc func flashButtonPressed(_ sender: UIButton) {
        
        isFlashOn = !isFlashOn
        // Change button title based on flash state
        let image = isFlashOn ? "bolt.fill" : "bolt.slash.fill"
        flashModeButton.setImage(UIImage(systemName: image)?.withTintColor(.white, renderingMode: .alwaysOriginal), for: .normal)
    }
  

    func showFocusBox(at point: CGPoint) {
           _ = previewLayer.captureDevicePointConverted(fromLayerPoint: point)
           
           // Calculate the rect for the focus box centered at the given point
           let boxSize: CGFloat = 100.0
           let boxRect = CGRect(x: point.x - boxSize / 2, y: point.y - boxSize / 2, width: boxSize, height: boxSize)
           
           // Update the box view's position and show it
           boxView.frame = boxRect
           boxView.isHidden = false
           
          
           // Hide the box after a short delay
           DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
               self.boxView.isHidden = true
               
           }
       }
     func showSlider(at point: CGPoint) {
         let yOffset: CGFloat = 2 * 35
         let sliderY =  point.y + yOffset
         exposureSlider.center = CGPoint(x: point.x , y: sliderY)
         exposureSlider.isHidden = false
          resetSliderHideTimer()
         DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
             self.exposureSlider.isHidden = true
             
         }
     }
  
     func resetSliderHideTimer() {
         // Invalidate the existing timer (if any)
        sliderHiderTimer?.invalidate()

         // Create a new timer to hide the slider after 5 seconds of inactivity
     sliderHiderTimer = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { [weak self] _ in
             self?.exposureSlider.isHidden = true
         }
     }
     
//     
//     @objc func handlePinchGesture(_ recognizer: UIPinchGestureRecognizer) {
//                guard AVCaptureDevice.default(for: .video) != nil else {
//                print("Unable to access the camera.")
//                return
//            }
//            
//            if recognizer.state == .changed {
//                var zoomFactor = recognizer.scale * currentZoomFactor
//                zoomFactor = max(1.0, min(zoomFactor, maxZoomFactor))
//                _ = round(zoomFactor / zoomStep) * zoomStep
//                
//                updateZoomFactor(zoomFactor)
//            }
//        }

     
     @objc func handleTap(_ recognizer: UITapGestureRecognizer) {
         if recognizer.state == .ended {
             let point = recognizer.location(in: cameraView)
             showFocusBox(at: point)
             updateFocus(at: point)
             showSlider(at: point)
         
         }
     }

    
    
  
    func updateZoomFactor(_ zoomFactor: CGFloat) {
        currentZoomFactor = zoomFactor
        
        
        guard let currentCamera = currentCamera else {
            print("current camera cannot available")
            return
        }
       // if activeCamera.position == .back {
            do {
                try currentCamera.lockForConfiguration()
                defer { currentCamera.unlockForConfiguration() }
                
                // Check if the active camera supports zooming
          
                    if currentCamera.activeFormat.videoMaxZoomFactor > 1.0 {
                        let maxZoomFactor = min(maxZoomFactor, currentCamera.activeFormat.videoMaxZoomFactor)
                        let scaledZoomFactor = max(1.0, min(zoomFactor, maxZoomFactor))
                        
                        
                        currentCamera.videoZoomFactor = scaledZoomFactor
                    }
                    
                  
                 else {
                    print("Zoom is not supported for the active camera.")
                }
            } catch {
                print("Error updating zoom factor: \(error)")
            }
        }
    

    
    func setupZoom(for camera: AVCaptureDevice) {
        do {
            try camera.lockForConfiguration()
            camera.videoZoomFactor = currentZoomFactor
            camera.unlockForConfiguration()
        } catch {
            print("Error setting up zoom: \(error)")
        }
    }

    func setupExposure(for camera: AVCaptureDevice) {
        do {
            try camera.lockForConfiguration()
            camera.exposureMode = .continuousAutoExposure
            camera.unlockForConfiguration()
        } catch {
            print("Error setting up exposure: \(error)")
        }
    }

    
    func updateCustomFocusAndExposure(at point: CGPoint) {
        guard let backCamera = AVCaptureDevice.default(for: .video) else {
            print("Unable to access the camera.")
            return
        }
        
        do {
            try backCamera.lockForConfiguration()
            defer { backCamera.unlockForConfiguration() }
            
            // Convert the point from the camera view's coordinate system to the preview layer's coordinate system
            let convertedPoint = previewLayer.captureDevicePointConverted(fromLayerPoint: point)
            
            // Update the custom focus and exposure points
            if backCamera.isFocusModeSupported(.autoFocus) && backCamera.isFocusPointOfInterestSupported {
                backCamera.focusMode = .autoFocus
                backCamera.focusPointOfInterest = convertedPoint
            }
            
            if backCamera.isExposureModeSupported(.autoExpose) && backCamera.isExposurePointOfInterestSupported {
                backCamera.exposureMode = .autoExpose
                backCamera.exposurePointOfInterest = convertedPoint
            }
        } catch {
            print("Error updating custom focus and exposure: \(error)")
        }
    }
    
    func updateFocusAndExposure(at point: CGPoint) {
        guard let backCamera = AVCaptureDevice.default(for: .video) else {
            print("Unable to access the camera.")
            return
        }
        
        do {
            try backCamera.lockForConfiguration()
            defer { backCamera.unlockForConfiguration() }
            
            // Convert the point from the camera view's coordinate system to the preview layer's coordinate system
            let convertedPoint = previewLayer.captureDevicePointConverted(fromLayerPoint: point)
            
            if backCamera.isFocusModeSupported(.continuousAutoFocus) && backCamera.isFocusPointOfInterestSupported {
                backCamera.focusMode = .continuousAutoFocus
                backCamera.focusPointOfInterest = convertedPoint
            }
            
            if backCamera.isExposureModeSupported(.continuousAutoExposure) && backCamera.isExposurePointOfInterestSupported {
                backCamera.exposureMode = .continuousAutoExposure
                backCamera.exposurePointOfInterest = convertedPoint
            }
        } catch {
            print("Error updating focus and exposure: \(error)")
        }
    }
    
    
   
    
//    func showFocusBox(at point: CGPoint) {
//        _ = previewLayer.captureDevicePointConverted(fromLayerPoint: point)
//        
//        // Calculate the rect for the focus box centered at the given point
//        let boxSize: CGFloat = 100.0
//        let boxRect = CGRect(x: point.x - boxSize / 2, y: point.y - boxSize / 2, width: boxSize, height: boxSize)
//        
//        // Update the box view's position and show it
//        boxView.frame = boxRect
//        boxView.isHidden = false
//        
//        // Hide the box after a short delay
//        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
//            self.boxView.isHidden = true
//        }
//    }
//    
    @objc func exposureSliderValueChanged(_ slider: UISlider) {
        let exposureValue = slider.value
        _ = max(exposureSlider.minimumValue, min(exposureSlider.maximumValue, exposureValue))
        
        // Apply the exposure value to the camera
        updateExposure(exposureValue)
    }
//    
////    @objc func exposureSliderValueChanged(_ slider: UISlider) {
//        guard let currentCamera = currentCamera else {
//            print("No current camera available.")
//            return
//        }
//
//        do {
//            try currentCamera.lockForConfiguration()
//
//            let exposureValue = slider.value
//            let clampedValue = max(exposureSlider.minimumValue, min(exposureSlider.maximumValue, exposureValue))
//
//            // Check the valid ISO range for the current active format
//            let minISO = currentCamera.activeFormat.minISO
//            let maxISO = currentCamera.activeFormat.maxISO
//            let adjustedISO = min(max(minISO, clampedValue * (maxISO - minISO) + minISO), maxISO)
//
//            currentCamera.setExposureModeCustom(duration: CMTime(seconds: 0.1, preferredTimescale: 100),
//                                                iso: adjustedISO,
//                                                completionHandler: { time in
//                print("Exposure set to: \(time) seconds, ISO: \(adjustedISO)")
//            })
//
//            currentCamera.unlockForConfiguration()
//        } catch {
//            print("Error adjusting exposure: \(error)")
//        }
//    }
//

//    
//    @objc func exposureSliderValueChanged(_ slider: UISlider) {
//        guard let device = AVCaptureDevice.default(for: .video) else { return }
//        
//        do {
//            try device.lockForConfiguration()
//            let exposureValue = slider.value
//            let minExposure = device.minExposureTargetBias
//            let maxExposure = device.maxExposureTargetBias
//            let newExposure = min(max(exposureValue, minExposure), maxExposure)
//            
//            device.setExposureTargetBias(newExposure, completionHandler: nil)
//         //   currentExposureValue = newExposure
//            device.unlockForConfiguration()
//        } catch {
//            print(error.localizedDescription)
//        }
//    }
//    
//    
    
    func calculateExposureValue(_ exposureValue: Float, for device: AVCaptureDevice) -> Float {
        let maxExposureValue = device.maxExposureTargetBias
        let minExposureValue = device.minExposureTargetBias
        return (exposureValue - minExposureValue) / (maxExposureValue - minExposureValue)
    }
    func calculateFocusLevel(_ focusValue:  Float, for device: AVCaptureDevice) -> Float{
        let maxFocusValue = device.maxExposureTargetBias
        let minFocusValue = device.minExposureTargetBias
        return (focusValue - minFocusValue) / (maxFocusValue - minFocusValue)
    }
    
    func updateFocus(at point: CGPoint, isCloseDepth: Bool = false) {
        guard let backCamera = AVCaptureDevice.default(for: .video) else {
            print("Unable to access the camera.")
            return
        }
        
        do {
            try backCamera.lockForConfiguration()
            defer { backCamera.unlockForConfiguration() }
            
            let convertedPoint = previewLayer.captureDevicePointConverted(fromLayerPoint: point)
            
            if backCamera.isFocusPointOfInterestSupported {
                backCamera.focusPointOfInterest = convertedPoint
            }
            
            if backCamera.isFocusModeSupported(.continuousAutoFocus) {
                backCamera.focusMode = isCloseDepth ? .autoFocus : .continuousAutoFocus
                
                currentFocusLevel = calculateFocusLevel(backCamera.exposureTargetBias, for: backCamera)
            }
        } catch {
            print("Error updating focus: \(error)")
        }
    }
    
    
    
    func updateExposure(_ value: Float) {
//        guard let backCamera = AVCaptureDevice.default(for: .video) else {
//            print("Unable to access the camera.")
//            return
//        }
        
        
        guard let currentCamera = currentCamera else {
            print("No current camera available")
            return
        }
        do {
            try currentCamera.lockForConfiguration()
            defer { currentCamera.unlockForConfiguration() }
            
            if currentCamera.isExposureModeSupported(.custom) {
                let minExposureValue = currentCamera.minExposureTargetBias
                let maxExposureValue = currentCamera.maxExposureTargetBias
                
                // Calculate the actual exposure value from the slider value
                let clampedValue = max(minExposureValue, min(maxExposureValue, value))
                currentCamera.setExposureTargetBias(clampedValue, completionHandler: nil)
                
                currentExposureValue = calculateExposureValue(clampedValue, for: currentCamera)
                
            }
        } catch {
            print("Error updating exposure: \(error)")
            
            
        }
        
    }
   
//    func updateExposure2(_ value: Float) {
//        if let backCamera = AVCaptureDevice.default(for: .video) {
//            do {
//                try backCamera.lockForConfiguration()
//                
//                // Calculate the relative exposure target bias within the valid range
//                let minExposure = backCamera.minExposureTargetBias
//                let maxExposure = backCamera.maxExposureTargetBias
//            
//                let relativeexposureValue = minExposure + (maxExposure - minExposure) * value
//
//                
//                // Set the exposure bias
//                backCamera.setExposureTargetBias(relativeexposureValue, completionHandler: nil)
//                
//                backCamera.unlockForConfiguration()
//                
//       
//                
//                // Update the UILabel to display the exposure value
//             
//            } catch {
//                print("Error updating exposure configuration: \(error)")
//            }
//        }
//    }
//   
//    func updateExposure2(_ value: Float) {
//        if let backCamera = AVCaptureDevice.default(for: .video) {
//            do {
//                try backCamera.lockForConfiguration()
//
//                // Calculate the relative exposure target bias within the valid range
//                let minExposure = backCamera.minExposureTargetBias
//                let maxExposure = backCamera.maxExposureTargetBias
//
//                // Clamp the value to the valid range
//                let clampedValue = min(maxExposure, max(minExposure, value))
//
//                let relativeExposureValue = minExposure + (maxExposure - minExposure) * clampedValue
//
//                // Set the exposure bias
//                backCamera.setExposureTargetBias(relativeExposureValue)
//
//                backCamera.unlockForConfiguration()
//            } catch {
//                print("Error updating exposure configuration: \(error)")
//            }
//        }
//    }
    
    func updateExposure2(_ value: Double) {
      //  if let backCamera = AVCaptureDevice.default(for: .video) {
            
        guard let currentCamera  = currentCamera  else {
            print("current camera did not works")
            
            return
        }
            do {
                //try backCamera.lockForConfiguration()
                
                try currentCamera.lockForConfiguration()

                // Calculate the relative exposure target bias within the valid range
                let minExposure = currentCamera.minExposureTargetBias
                let maxExposure = currentCamera.maxExposureTargetBias
    

                // Clamp the value to the valid range
                let clampedValue = min(maxExposure, max(minExposure, Float(value)))

                // Calculate the relative percentage within the valid range
                let relativePercentage = minExposure + (maxExposure - minExposure) * clampedValue

                // Set the exposure bias based on the relative percentage
                currentCamera.setExposureTargetBias(relativePercentage, completionHandler: nil)

                currentCamera.unlockForConfiguration()
            } catch {
                print("Error updating exposure configuration: \(error)")
            }
        }
    


//            
//        func setupButtons() {
//            //CaptureButton
//            captureButton = UIButton(type: .custom) // Use custom button type
//            captureButton.translatesAutoresizingMaskIntoConstraints = false
//            captureButton.backgroundColor = .white
//            let captureButtonWidth: CGFloat = 70.0
//            captureButton.layer.cornerRadius = 0.5 * captureButtonWidth
//            captureButton.addTarget(self, action: #selector(capturePhoto(_:)), for: .touchUpInside)
//            view.addSubview(captureButton)
//            
//            
//            //CameraSwitch
//            cameraSwitchButton = UIButton(type: .system)
//            cameraSwitchButton.translatesAutoresizingMaskIntoConstraints = false
//            cameraSwitchButton.setTitleColor(.white, for: .normal)
//            cameraSwitchButton.transform = CGAffineTransform(scaleX: 1, y: 1)
//            cameraSwitchButton.setTitle("⎣⎤", for: .normal)
//            cameraSwitchButton.titleLabel?.font = UIFont.systemFont(ofSize: 20 , weight: .bold)
//            cameraSwitchButton.addTarget(self, action: #selector(switchCameraButtonTapped(_:)), for: .touchUpInside)
//            view.addSubview(cameraSwitchButton)
//            
//            
//            //FlashMode
//            flashModeButton = UIButton(type: .system)
//            flashModeButton.translatesAutoresizingMaskIntoConstraints = false
//            flashModeButton.setTitle("⚡︎", for: .normal)
//            flashModeButton.setTitleColor(.white, for: .normal)
//            flashModeButton.transform = CGAffineTransform(scaleX: 2, y: 2)
//            flashModeButton.titleLabel?.font = UIFont.systemFont(ofSize: 25, weight: .bold)
//            flashModeButton.addTarget(self, action: #selector(toggleFlashMode(_:)), for: .touchUpInside)
//            view.addSubview(flashModeButton)
//            
//            
//            
//            aspectControll = UISegmentedControl(items: ["4:3","16:9","1:1"])
//            aspectControll.frame = CGRect(x: 50, y: 100, width: 300, height: 40)
//            aspectControll.selectedSegmentIndex = 0
//            aspectControll.clipsToBounds = true
//            aspectControll.layer.masksToBounds = true
//            aspectControll.layer.borderColor = UIColor.white.cgColor
//          //  aspectControll.addTarget(self, action: #selector(segmentControllValueChanged(_:)), for: .valueChanged)
//            aspectControll.translatesAutoresizingMaskIntoConstraints = false
//            view.addSubview(aspectControll)
//            
//      
//            
//            
//            timerButton = UIButton(type: .system)
//            timerButton.translatesAutoresizingMaskIntoConstraints = false
//            timerButton.setTitle("◴", for: .normal)
//            timerButton.setTitleColor(.white, for: .normal)
//            timerButton.transform = CGAffineTransform(scaleX: 1, y: 1)
//            timerButton.addTarget(self, action: #selector(timerButtonTapped(_: )), for: .touchUpInside)
//            view.addSubview(timerButton)
//            
//            
//            timerLabel = UILabel()
//            timerLabel.translatesAutoresizingMaskIntoConstraints = false
//            timerLabel.text = ""
//            timerLabel.textAlignment = .center
//            timerLabel.font = UIFont.systemFont(ofSize: 24)
//            view.addSubview(timerLabel)
//
//            
//            
//            levelView = UIView(frame: CGRect(x: 0, y: 0, width: cameraView.frame.width, height: 2))
//            levelView.backgroundColor = UIColor.red // Choose your color
//            levelView.center = cameraView.center
//            cameraView.addSubview(levelView)
//            
//            
//            wideControll = UISegmentedControl(items: ["1x", "0.5"])
//            wideControll.translatesAutoresizingMaskIntoConstraints = false
//            wideControll.selectedSegmentIndex = 0 // Select the default segment
//            wideControll.addTarget(self, action: #selector(wideAngleValueChanged(_:)), for: .valueChanged)
//            view.addSubview(wideControll)
//            
//         
//               
//            
//      
//            
//            NSLayoutConstraint.activate([
//                captureButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//                captureButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
//                captureButton.widthAnchor.constraint(equalToConstant: captureButtonWidth),
//                captureButton.heightAnchor.constraint(equalTo: captureButton.widthAnchor),
//                
//                cameraSwitchButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 80),
//                cameraSwitchButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
//                cameraSwitchButton.widthAnchor.constraint(equalToConstant: 40),
//                cameraSwitchButton.heightAnchor.constraint(equalToConstant: 40),
//                
//                flashModeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20), // Align to the right edge
//                flashModeButton.topAnchor.constraint(equalTo: cameraSwitchButton.topAnchor), // Align the top with cameraSwitchButton's top
//                flashModeButton.widthAnchor.constraint(equalToConstant: 50),
//                flashModeButton.heightAnchor.constraint(equalToConstant: 50),
//                
//                 aspectControll.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//                
//                 aspectControll.centerYAnchor.constraint(equalTo: view.bottomAnchor,constant: -150 ),
//                
//                
//                  timerButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20), // 20 points from the right edge
//                  timerButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),   // 20 points from the bottom edge
//                  timerButton.widthAnchor.constraint(equalToConstant: 80), // Set the desired width
//                  timerButton.heightAnchor.constraint(equalToConstant: 40),
//                  timerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//                  timerLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
//                
//                
//  
//            
//                
//                wideControll.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//                wideControll.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -200)
//
//                
//            ])
//            
//            
//        }
//        
//        func setupBoxView() {
//            
//            boxView = UIView()
//            boxView.translatesAutoresizingMaskIntoConstraints = false
//            boxView.layer.borderWidth = 2.0
//            boxView.layer.borderColor = UIColor.yellow.cgColor
//            boxView.isHidden = true
//            cameraView.addSubview(boxView)
//            
//        }
//        
//        func setupExposureSlider() {
//            exposureSlider = UISlider()
//            exposureSlider.translatesAutoresizingMaskIntoConstraints = false
//            exposureSlider.minimumValue = -5.0 // Set the minimum exposure value you want
//            exposureSlider.maximumValue = 5.0  // Set the maximum exposure value you want
//            exposureSlider.value = 0.0        // Set the initial exposure value
//            exposureSlider.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
//            exposureSlider.addTarget(self, action: #selector(exposureSliderValueChanged(_:)), for: .valueChanged)
//            cameraView.addSubview(exposureSlider)
//            
//            
//            
//            let thumbImage = UIImage(named: "☼")?.withRenderingMode(.alwaysOriginal)
//            exposureSlider.setThumbImage(thumbImage, for: .normal)
//            let trackImage = UIImage.imageWithColor(UIColor.yellow, size: CGSize(width: 1, height: 2)) // Adjust the height as needed
//            exposureSlider.setMinimumTrackImage(trackImage, for: .normal)
//            exposureSlider.setMaximumTrackImage(trackImage, for: .normal)
//            let _: CGFloat = 1.0
//            exposureSlider.setMinimumTrackImage(trackImage, for: .normal)
//            exposureSlider.setMaximumTrackImage(trackImage, for: .normal)
//            
//                NSLayoutConstraint.activate([
//                    
//                           exposureSlider.leadingAnchor.constraint(equalTo: cameraView.leadingAnchor, constant: 20),
//                           exposureSlider.trailingAnchor.constraint(equalTo: cameraView.trailingAnchor, constant: -20),
//                           exposureSlider.bottomAnchor.constraint(equalTo: cameraSwitchButton.topAnchor, constant: 60),
//                           exposureSlider.heightAnchor.constraint(equalToConstant: 40.0) // Set the desired height of the slider
//
//            ])
//            
//            cameraView.bringSubviewToFront(exposureSlider)
//        }
    
    
    func setupButtons() {
        //CaptureButton
        let symbolconfig = UIImage.SymbolConfiguration(pointSize: 40)
        let cameraImage = UIImage(systemName: "circle.circle.fill", withConfiguration: symbolconfig)?
            .withTintColor(.white, renderingMode: .alwaysOriginal)
        captureButton = UIButton(type: .system) // Use custom button type
        captureButton.setImage(cameraImage, for: .normal)
        
        captureButton.translatesAutoresizingMaskIntoConstraints = false
        
        
        captureButton.addTarget(self, action: #selector(capturePhoto(_:)), for: .touchUpInside)
        view.addSubview(captureButton)
        
        
        //CameraSwitch
        
        let cameraswitchImage = UIImage(systemName: "arrow.triangle.2.circlepath.camera")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        cameraSwitchButton = UIButton(type: .system)
        cameraSwitchButton.setImage(cameraswitchImage, for: .normal)
        cameraSwitchButton.translatesAutoresizingMaskIntoConstraints = false
        cameraSwitchButton.setTitleColor(.white, for: .normal)
        cameraSwitchButton.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        
        
        cameraSwitchButton.addTarget(self, action: #selector(switchCameraButtonTapped(_:)), for: .touchUpInside)
        view.addSubview(cameraSwitchButton)
        
        
        //FlashMode
        let flashimage = UIImage(systemName: "bolt.slash.fill")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        flashModeButton = UIButton(type: .system)
        flashModeButton.setImage(flashimage, for: .normal)
        flashModeButton.translatesAutoresizingMaskIntoConstraints = false
        flashModeButton.setTitleColor(.white, for: .normal)
        flashModeButton.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
    flashModeButton.addTarget(self, action: #selector(flashButtonPressed(_:)), for: .touchUpInside)
        view.addSubview(flashModeButton)
        
        
        
        aspectControll = UISegmentedControl(items: ["4:3","16:9","1:1"])
        aspectControll?.frame = CGRect(x: 50, y: 100, width: 300, height: 40)
        aspectControll?.selectedSegmentIndex = 0
        aspectControll?.clipsToBounds = true
        aspectControll?.layer.masksToBounds = true
        aspectControll?.layer.borderColor = UIColor.white.cgColor
    
        aspectControll?.addTarget(self, action: #selector(segmentControllValueChanged(_:)), for: .valueChanged)
       
        aspectControll?.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(aspectControll!)
        
        
        let timerimage = UIImage(systemName: "gauge.with.needle")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        
        timerButton = UIButton(type: .system)
        timerButton.setImage(timerimage, for: .normal)
        timerButton.translatesAutoresizingMaskIntoConstraints = false
        timerButton.transform = CGAffineTransform(scaleX: 1, y: 1)
        timerButton.addTarget(self, action: #selector(timerButtonTapped(_: )), for: .touchUpInside)
        view.addSubview(timerButton)
        
        
        timerLabel = UILabel()
        timerLabel.translatesAutoresizingMaskIntoConstraints = false
        timerLabel.text = ""
        timerLabel.textColor = .white
        timerLabel.textAlignment = .center
        timerLabel.font = UIFont.systemFont(ofSize: 24)
        view.addSubview(timerLabel)
        
        
        
        
        
        
        wideControll = UISegmentedControl(items: ["1x", "0.5"])
        wideControll.translatesAutoresizingMaskIntoConstraints = false
        wideControll.selectedSegmentIndex = 0 // Select the default segment
        wideControll.addTarget(self, action: #selector(wideAngleValueChanged(_:)), for: .valueChanged)
        view.addSubview(wideControll)
 
        
        NSLayoutConstraint.activate([
            captureButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            captureButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30),
            // captureButton.widthAnchor.constraint(equalToConstant: captureButtonWidth),
            captureButton.heightAnchor.constraint(equalTo: captureButton.widthAnchor),
            
            
            flashModeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20), // Align to the right edge
            flashModeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 60), // Align the top with cameraSwitchButton's top
            flashModeButton.widthAnchor.constraint(equalToConstant: 50),
            flashModeButton.heightAnchor.constraint(equalToConstant: 50),
            
            
            
            
            aspectControll!.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            aspectControll!.centerYAnchor.constraint(equalTo: view.bottomAnchor,constant: -130 ),
            

            
            cameraSwitchButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20), // 20 points from the right edge
            cameraSwitchButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),   // 20 points from the bottom edge
            cameraSwitchButton.widthAnchor.constraint(equalToConstant: 80), // Set the desired width
            cameraSwitchButton.heightAnchor.constraint(equalToConstant: 40),
            //cameraSwitchButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            //  cameraSwitchButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            timerButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -300),
            timerButton.bottomAnchor.constraint(equalTo: cameraSwitchButton.bottomAnchor),
            timerButton.widthAnchor.constraint(equalToConstant: 50),
            timerButton.heightAnchor.constraint(equalToConstant: 50),
            timerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            timerLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            
            
            wideControll.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            wideControll.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -185)
            
            
        ])
        
        
    }

    func setupBoxAndSliderView() {
        
        boxView = UIView()
        boxView.translatesAutoresizingMaskIntoConstraints = false
        boxView.layer.borderWidth = 2.0
        boxView.layer.borderColor = UIColor.yellow.cgColor
        boxView.isHidden = true
        view.addSubview(boxView)
         
        
//            aeaftext = UILabel()
//            aeaftext.text = "AE/AF Locked"
//            aeaftext.font = .systemFont(ofSize: 12)
//            aeaftext.textColor = .white
//            aeaftext.isHidden = true
//            aeaftext.translatesAutoresizingMaskIntoConstraints = false
//            view.addSubview(aeaftext)
        
        exposureSlider = UISlider()
       
        exposureSlider.minimumValue = -5.0 // Set the minimum exposure value you want
        exposureSlider.maximumValue = 5.0// Set the maximum exposure value you want
        exposureSlider.value = 0.0 // Set the initial exposure value
        exposureSlider.frame = CGRect(x: 50, y: 100, width: 20, height: 200)
        exposureSlider.addTarget(self, action: #selector(exposureSliderValueChanged(_:)), for: .valueChanged)
        exposureSlider.minimumTrackTintColor = .yellow
        exposureSlider.maximumTrackTintColor = .white
        exposureSlider.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)

      let thumbImage = UIImage(systemName: "sun.max.fill" )?.withTintColor(.yellow, renderingMode: .alwaysOriginal)
        let thumbSize = CGSize(width: 45, height: 45)
        // Resize the thumb image
        let resizedThumbImage = thumbImage?.resize(targetSize: thumbSize)
        // Set the thumb image for the slider
        exposureSlider.setThumbImage(resizedThumbImage, for: .normal)
        view.addSubview(exposureSlider)
       view.bringSubviewToFront(exposureSlider)
        
        exposureSlider.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            exposureSlider.widthAnchor.constraint(equalToConstant: 250), // Adjust width here
            exposureSlider.heightAnchor.constraint(equalToConstant: 50),
             exposureSlider.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                  exposureSlider.centerYAnchor.constraint(equalTo: view.centerYAnchor),
               ])

        
    }
    
        
    func uploadImage(image: UIImage) {
        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
            print("Failed to convert image to data")
            return
        }

        let url = URL(string: "http://10.10.101.92:8000/api/puttemplate")!
        let boundary = UUID().uuidString

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

        var data = Data()

        // Add the image data to the raw http request data
        data.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
        data.append("Content-Disposition: form-data; name=\"file\"; filename=\"user_image.jpg\"\r\n".data(using: .utf8)!)
        data.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
        data.append(imageData)
        data.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)

        // Add JSON data to the request
        let json_data  = [
               
                   "zoomLevel": currentZoomFactor,
                   "exposureValue": currentExposureValue,
                   "focusLevel": currentFocusLevel,
                   "flasMode" : isFlashOn,
                   "Timer" : timerDuration,
                   "aspectRatio" : selectedAspectRatio,
                   "cameralens" : selectedlens,
                   "cameraangle" : finalAngleFromPicture,
                   "cameraposition" : positionString
                   
                   
        ] as [String : Any]



        
        // Add JSON data to the request
        if let json = try? JSONSerialization.data(withJSONObject: json_data, options: []) {
            if let jsonString = String(data: json, encoding: .utf8) {
                print("JSON Data: \(jsonString)")
            }

            data.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
            data.append("Content-Disposition: form-data; name=\"json_data\"\r\n".data(using: .utf8)!)
            data.append("Content-Type: application/json\r\n\r\n".data(using: .utf8)!)
            data.append(json)
            data.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)
        }


        let task = URLSession.shared.uploadTask(with: request, from: data) { responseData, response, error in
            if let error = error {
                print("Error: \(error)")
                return
            }

            if let httpResponse = response as? HTTPURLResponse {
                if (200...299).contains(httpResponse.statusCode) {
                    if let responseData = responseData {
                        do {
                            let json = try JSONSerialization.jsonObject(with: responseData, options: [])
                            print("API Response: \(json)")
                        } catch {
                            print("Error parsing JSON: \(error)")
                        }
                    }
                } else {
                    print("HTTP Response Status Code: \(httpResponse.statusCode)")
                }
            }
        }

        task.resume()
    }


        
//        
//        func setupGestures() {
//            
//            let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleFlashModeChange(_:)))
//            flashModeButton.addGestureRecognizer(longPressGesture)
//            
//            let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(handlePinchGesture(_:)))
//            cameraView.addGestureRecognizer(pinchGesture)
//            pinchGesture.delegate = self
//            
//            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
//            cameraView.addGestureRecognizer(tapGesture)
//            tapGesture.delegate = self
//            cameraView.isUserInteractionEnabled = true
//            
//            let aeTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleAETap(_:)))
//            let afTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleAFTap(_:)))
//            cameraView.addGestureRecognizer(aeTapGesture)
//            cameraView.addGestureRecognizer(afTapGesture)
//            aeTapGesture.delegate = self
//            afTapGesture.delegate = self
//            cameraView.isUserInteractionEnabled = true
//            
//            
//        }
//    }
    
    
    func setupGestures() {

        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(handlePinchGesture(_:)))
      view.addGestureRecognizer(pinchGesture)
        pinchGesture.delegate = self
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
       view.addGestureRecognizer(tapGesture)
        tapGesture.delegate = self
        view.isUserInteractionEnabled = true

//           let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(_:)))
//            longPressGesture.minimumPressDuration = 2
//            tapGesture.delegate = self
//         view.addGestureRecognizer(longPressGesture)
        
    }
}


class GridView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.clear
        isUserInteractionEnabled = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        context?.setStrokeColor(UIColor.white.cgColor)
        context?.setLineWidth(1.0)
        
        // Draw vertical lines
        for i in 1..<3 {
            let x = rect.width / 3 * CGFloat(i)
            context?.move(to: CGPoint(x: x, y: 0))
            context?.addLine(to: CGPoint(x: x, y: rect.height))
        }
        
        // Draw horizontal lines
        for i in 1..<4 {
            let y = rect.height / 3 * CGFloat(i)
            context?.move(to: CGPoint(x: 0, y: y))
            context?.addLine(to: CGPoint(x: rect.width, y: y))
        }
        
        context?.strokePath()
    }
}

extension UIImage {
    func resize(targetSize: CGSize) -> UIImage {
        let size = self.size
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        let newSize = widthRatio > heightRatio ?
        CGSize(width: size.width * heightRatio, height: size.height * heightRatio) :
        CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        self.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage ?? self
    }
}


