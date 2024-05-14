import CoreMotion

class CoreMotionManager {
    // Shared instance for the singleton pattern
    static let shared = CoreMotionManager()
    
    // Instance of CMMotionManager
    public let motionManager = CMMotionManager()
    
    // Closure to handle gyroscope updates
    var gyroUpdate: ((CMRotationRate) -> Void)?

    /// Starts gyroscope.
    func startGyroscope() {
        if motionManager.isGyroAvailable {
            // Set the update interval to 60
            motionManager.gyroUpdateInterval = 1.0 / 60.0
            // Start receiving gyroscope updates
            motionManager.startGyroUpdates(to: .main) { [weak self] (gyroData, error) in
                // Check for errors
                guard error == nil, let gyroData = gyroData else {
                    print("Gyroscope error: \(error?.localizedDescription ?? "Unknown error")")
                    return
                }
                // Call the gyroUpdate
                self?.gyroUpdate?(gyroData.rotationRate)
            }
        } else {
            print("Gyroscope is not available on this device.")
        }
    }

    /// Stops gyroscope updates.
    func stopGyroscope() {
        motionManager.stopGyroUpdates()
    }
}
