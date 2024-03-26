//
//  CoinChartViewController.swift
//  coinTracker
//
//  Created by Atilla Poyraz on 1.12.2023.
//

import UIKit
import DGCharts
import Kingfisher

class CoinChartViewController: UIViewController, ChartViewDelegate {
    var viewModel: CoinChartViewModel!

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var symbolLabel: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var chartView: LineChartView!

    override func viewDidLoad() {
        super.viewDidLoad()

        nameLabel.text = viewModel.name
        symbolLabel.text = "(\(viewModel.symbol))"
        quoteLabel.text = viewModel.quote

        if let imageURL = viewModel.imageURL {
            imgView.kf.setImage(with: imageURL, placeholder: UIImage(named: "placeholderImage"), options: [.transition(.fade(0.2)), .scaleFactor(UIScreen.main.scale), .processor(ResizingImageProcessor(referenceSize: CGSize(width: 64, height: 64)))])
        }

        setData()

        chartView.delegate = self
    }
	
    func setData() {
        let xValues = [
            "",
            "1Y",
            "30D",
            "7D",
            "1D",
            "12H",
            "6H",
            "1H",
            "30M",
            "15M",
            "Current"
        ]

        // Assign x-axis labels to the chartView
        chartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: xValues)
        chartView.xAxis.labelCount = xValues.count
        chartView.xAxis.granularity = 1
        
        let yValues = viewModel.chartData

        let set1 = LineChartDataSet(entries: yValues, label: "Times")
        set1.drawCirclesEnabled = true
        set1.mode = .cubicBezier
        set1.lineWidth = 3
        set1.setColor(.white)
        set1.fillAlpha = 0.8
        set1.drawFilledEnabled = true
        set1.drawHorizontalHighlightIndicatorEnabled = false
        set1.highlightColor = .systemRed
        chartView.backgroundColor = .lightGray
        chartView.rightAxis.enabled = false
        let yAxis = chartView.leftAxis
        yAxis.labelFont = .boldSystemFont(ofSize: 12)
        yAxis.setLabelCount(30, force: false)
        yAxis.labelTextColor = .white
        yAxis.axisLineColor = .white
        yAxis.labelPosition = .outsideChart

        chartView.animate(xAxisDuration: 0)

        let marker = PillMarker(color: .white, font: UIFont.boldSystemFont(ofSize: 14), textColor: .black)
        chartView.marker = marker
        chartView.xAxis.labelPosition = .bottom
        chartView.xAxis.labelFont = .boldSystemFont(ofSize: 12)
        chartView.xAxis.setLabelCount(11, force: false)
        chartView.xAxis.labelTextColor = .white
        chartView.xAxis.axisLineColor = .white

        let data = LineChartData(dataSet: set1)
        chartView.data = data
        data.setDrawValues(false)
    }
    class PillMarker: MarkerImage {

        private (set) var color: UIColor
        private (set) var font: UIFont
        private (set) var textColor: UIColor
        private var labelText: String = ""
        private var attrs: [NSAttributedString.Key: AnyObject]!

        static let formatter: DateComponentsFormatter = {
            let f = DateComponentsFormatter()
            f.allowedUnits = [.minute, .second]
            f.unitsStyle = .short
            return f
        }()

        init(color: UIColor, font: UIFont, textColor: UIColor) {
            self.color = color
            self.font = font
            self.textColor = textColor

            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .center
            attrs = [.font: font, .paragraphStyle: paragraphStyle, .foregroundColor: textColor, .baselineOffset: NSNumber(value: -4)]
            super.init()
        }

        override func draw(context: CGContext, point: CGPoint) {
            // custom padding around text
            let labelWidth = labelText.size(withAttributes: attrs).width + 12
            // if you modify labelHeigh you will have to tweak baselineOffset in attrs
            let labelHeight = labelText.size(withAttributes: attrs).height + 4

            // place pill above the marker, centered along x
            var rectangle = CGRect(x: point.x, y: point.y, width: labelWidth, height: labelHeight)
            rectangle.origin.x -= rectangle.width / 2.0
            let spacing: CGFloat = 20
            rectangle.origin.y -= rectangle.height + spacing

            // rounded rect
            let clipPath = UIBezierPath(roundedRect: rectangle, cornerRadius: 6.0).cgPath
            context.addPath(clipPath)
            context.setFillColor(UIColor.white.cgColor)
            context.setStrokeColor(UIColor.black.cgColor)
            context.closePath()
            context.drawPath(using: .fillStroke)

            // add the text
            labelText.draw(with: rectangle, options: .usesLineFragmentOrigin, attributes: attrs, context: nil)
        }

        override func refreshContent(entry: ChartDataEntry, highlight: Highlight) {
            let priceString = String(format: "$%.5f", entry.y)

            var additionalInfo = ""
            switch entry.x {
            case 1:
                additionalInfo = "1 Year"
            case 2:
                additionalInfo = "30 Days"
            case 3:
                additionalInfo = "7 Days"
            case 4:
                additionalInfo = "1 Day"
            case 5:
                additionalInfo = "12 Hours"
            case 6:
                additionalInfo = "6 Hours"
            case 7:
                additionalInfo = "1 Hour"
            case 8:
                additionalInfo = "30 Minutes"
            case 9:
                additionalInfo = "15 Minutes"
            case 10:
                additionalInfo = "Current"
            default:
                additionalInfo = ""
            }

            labelText = "\(additionalInfo)\n\(priceString)"
        }


        private func customString(_ value: Double) -> String {
            let formattedString = PillMarker.formatter.string(from: TimeInterval(value))!
            return "\(formattedString)"
        }
    }
}
