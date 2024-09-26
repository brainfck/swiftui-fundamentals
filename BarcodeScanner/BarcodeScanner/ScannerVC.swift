//
//  ScannerVC.swift
//  BarcodeScanner
//
//  Created by Mykhailo Tsuber on 9/22/24.
//

import AVFoundation
import Foundation
import UIKit

enum CameraError: String {
  case invalidDeviceInput = "Something is wrong with the camera. We are unable to capture the input."
  case invalidScannedValue = "Value scanned is not valid. This app scans EAN-8 and EAN-13 barcode formats."
}

protocol ScannerVCDelegate: class {
  func didFind(barcode: String)
  func didSurface(error: CameraError)
}

final class ScannerVC: UIViewController {
  let captureSession = AVCaptureSession()
  var previewLayer: AVCaptureVideoPreviewLayer?
  weak var scannerDelegate: ScannerVCDelegate?

  init(scannerDelegate: ScannerVCDelegate) {
    super.init(nibName: nil, bundle: nil)
    self.scannerDelegate = scannerDelegate
  }

  @available(*, unavailable)
  required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupCaptureSession()
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    
    guard let previewLayer else {
      scannerDelegate?.didSurface(error: .invalidDeviceInput)
      return
    }
    
    previewLayer.frame = view.layer.bounds
  }
  
  private func setupCaptureSession() {
    guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else {
      scannerDelegate?.didSurface(error: .invalidDeviceInput)
      return
    }
    
    let videoInput: AVCaptureDeviceInput
    do {
      try videoInput = AVCaptureDeviceInput(device: videoCaptureDevice)
    } catch {
      scannerDelegate?.didSurface(error: .invalidDeviceInput)
      return
    }
    
    if captureSession.canAddInput(videoInput) {
      captureSession.addInput(videoInput)
    } else {
      scannerDelegate?.didSurface(error: .invalidDeviceInput)
      return
    }
    
    let metadataOutput = AVCaptureMetadataOutput()
    
    if captureSession.canAddOutput(metadataOutput) {
      captureSession.addOutput(metadataOutput)
      metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
      metadataOutput.metadataObjectTypes = [.ean8, .ean13]
    } else {
      scannerDelegate?.didSurface(error: .invalidDeviceInput)
      return
    }
    
    previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
    previewLayer!.videoGravity = .resizeAspectFill
    view.layer.addSublayer(previewLayer!)
    
    captureSession.startRunning()
  }
}

extension ScannerVC: AVCaptureMetadataOutputObjectsDelegate {
  func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
    guard let object = metadataObjects.first else {
      scannerDelegate?.didSurface(error: .invalidScannedValue)
      return
    }
    
    guard let machineReadableObject = object as? AVMetadataMachineReadableCodeObject else {
      scannerDelegate?.didSurface(error: .invalidScannedValue)
      return
    }
    
    guard let barcode = machineReadableObject.stringValue else {
      scannerDelegate?.didSurface(error: .invalidScannedValue)
      return
    }
    
    scannerDelegate?.didFind(barcode: barcode)
  }
}
