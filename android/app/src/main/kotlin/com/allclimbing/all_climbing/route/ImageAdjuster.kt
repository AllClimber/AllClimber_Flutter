package com.allclimbing.all_climbing.route

import org.opencv.imgproc.Imgproc
import org.opencv.core.Core
import org.opencv.core.CvType
import org.opencv.core.Mat
import org.opencv.core.MatOfPoint
import org.opencv.core.Rect
import org.opencv.core.Scalar
import org.opencv.core.Size
import org.opencv.imgcodecs.Imgcodecs
import java.io.File

class ImageAdjustor {

    fun adjustImage(originalImage: String, brightness: Double, saturation: Double): File {
        val processedMat = Imgcodecs.imread(originalImage)

        Imgproc.cvtColor(processedMat, processedMat, Imgproc.COLOR_BGR2HSV)
        processedMat.adjustBrightness(brightness)
        processedMat.adjustSaturation(saturation)
        processedMat.shift(15.0, 50.0)
        processedMat.convertColorHSV2Gray()
        processedMat.blur(Size(1.0, 1.0), 0.0)
        processedMat.enhanceEdges()

        val originalMat = Imgcodecs.imread(originalImage)
        val holds = processedMat.extractHolds()
        val holdIndicatedImage = originalMat.indicateHolds(holds)

        val adjustedImage = File.createTempFile("adjusted_image", ".jpg")
        Imgcodecs.imwrite(adjustedImage.path, holdIndicatedImage)
        return adjustedImage
    }

    /**
     * 이미지의 밝기와 채도를 조절한다.
     * 이미지는 HSV 색체계여야 한다.
     */
    private fun Mat.adjustBrightness(brightness: Double) {
        convertTo(this, CvType.CV_8U, 1.0, brightness)
    }

    private fun Mat.adjustSaturation(saturation: Double) {
        Core.multiply(this, Scalar(saturation), this)
    }

    // 평활화 (노이즈 감소, 색의 경계를 부드럽게 하면서 일관된 영역은 강조)
    private fun Mat.shift(sp: Double, sr: Double) {
        Imgproc.pyrMeanShiftFiltering(this, this, sp, sr)
    }

    private fun Mat.convertColorHSV2Gray() {
        Imgproc.cvtColor(this, this, Imgproc.COLOR_HSV2BGR)
        Imgproc.cvtColor(this, this, Imgproc.COLOR_BGR2GRAY)
    }

    // 블러 처리 (노이즈를 제거)
    private fun Mat.blur(ksize: Size, sigmaX: Double) {
        Imgproc.GaussianBlur(this, this, ksize, sigmaX)
    }

    // 엣지 강조 (3*3 단위의 커널을 이미지에 적용하여 미분하여 경계를 강조한다.)
    private fun Mat.enhanceEdges() {
        val kernel = Mat(3, 3, CvType.CV_32F)
        kernel.put(0, 0, -1.0, -1.0, -1.0, -1.0, 8.0, -1.0, -1.0, -1.0, -1.0)
        val edges = Mat()
        Imgproc.filter2D(this, edges, -1, kernel)
        Core.addWeighted(this, 1.0, edges, 1.5, 0.0, this)
    }

    private fun Mat.extractHolds(): List<Rect> {
        val edges = Mat()
        Imgproc.Canny(this, edges, 50.0, 150.0, 3)

        val contours: List<MatOfPoint> = ArrayList()
        val hierarchy = Mat()
        Imgproc.findContours(
            edges,
            contours,
            hierarchy,
            Imgproc.RETR_EXTERNAL,
            Imgproc.CHAIN_APPROX_SIMPLE
        )

        val minContourSize = 15.0
        val maxContourSize = 100.0
        return contours.filter {
            Imgproc.contourArea(it) in (minContourSize..maxContourSize)
        }.map { Imgproc.boundingRect(it) }
    }

    private fun Mat.indicateHolds(holds: List<Rect>): Mat {
        val holdIndicatedImage = clone()
        for (hold in holds) {
            Imgproc.rectangle(holdIndicatedImage, hold.tl(), hold.br(), Scalar(0.0, 255.0, 0.0), 2)
        }

        return holdIndicatedImage
    }
}