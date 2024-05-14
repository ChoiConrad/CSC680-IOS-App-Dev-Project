import CoreMotion
@testable import GoodFinanceBadCalculator

class MockCoreMotionManager: CoreMotionManager {
    override func startGyroscope() {
    }

    func simulateGyroData(rotationRate: CMRotationRate) {
        gyroUpdate?(rotationRate)
    }
}
