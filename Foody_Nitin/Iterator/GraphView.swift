//
//  GraphView.swift
//  MyGraph
//
//  Created by npiprava on 7/2/15.
//  Copyright (c) 2015 Nit. All rights reserved.
//

import UIKit

class GraphView: UIView {

    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    
   // let data: NSMutableArray!
    var foodImportants:[struct_important] = []
    struct constant {
      
        static let kGraphHeight = 400
        static let kDefaultGraphWidth = graphWidth
        static let kOffsetX = 80
        static let kStepX = 10
        static let kGraphBottom = 300
        static let kGraphTop = 0
        static let kStepY = 30
        static let kOffsetY = 20
        static let kBarTop = 10
        static let kBarHeight = 20
        static let axisPoint_Font = UIFont(name: "Helvetica", size: 10.0)
        
    }
    
    func roundToNearestQuarter(num : Float) -> Float {
        return round(num * 4.0)/4.0
    }
    
    override func drawRect(rect: CGRect) {
        
        self.userInteractionEnabled = false
        // Drawing code
       let important  = self.foodImportants[1] as struct_important
       let context = UIGraphicsGetCurrentContext();
        
        //Draw the graph Background
        let backgroundImage = UIImage(named: "graphBackGround.png")
        let imageRect = CGRect(x: 0, y: 0, width: backgroundImage!.size.width, height: backgroundImage!.size.height);
        CGContextDrawImage(context, imageRect, backgroundImage?.CGImage)
        
        CGContextSetLineWidth(context, 0.6);
        CGContextSetStrokeColorWithColor(context, UIColor.lightGrayColor().CGColor)
        
        //Draw grid for graph
        let howManyvertical:Int = (constant.kDefaultGraphWidth) / constant.kStepX
        let howManyHorizontal: Int = (constant.kGraphBottom - constant.kGraphTop - constant.kOffsetY) / constant.kStepY
        
        //Vertical Grids
        for var i = 0; i < howManyvertical; i++
        {
            CGContextMoveToPoint(context, CGFloat((constant.kOffsetX + i * constant.kStepX)), CGFloat(constant.kGraphTop))
            CGContextAddLineToPoint(context, CGFloat((constant.kOffsetX + i * constant.kStepX)), CGFloat(constant.kGraphBottom))
            
            //Draw X-axix point
            let xValue:NSString = "\(i * 10).00"
            let point = CGPointMake(CGFloat(constant.kOffsetX + 3 + i * constant.kStepX), CGFloat(constant.kOffsetY - 5))
            xValue.drawWithBasePoint(point,  angle: CGFloat(-M_PI_2), font: constant.axisPoint_Font!)
        }
        
        //Horizontal Grills
        for var i = 0; i < howManyHorizontal; i++
        {
            CGContextMoveToPoint(context, CGFloat (constant.kOffsetX), CGFloat((constant.kGraphBottom - constant.kOffsetY - i * constant.kStepY)));
            CGContextAddLineToPoint(context, CGFloat(screenSize.width), CGFloat(constant.kGraphBottom - constant.kOffsetY - i * constant.kStepY));
            
        }
        
        CGContextSetLineDash(context, CGFloat(0.0), [2.0, 2.0], 2) // Add Dash Pattern
        CGContextStrokePath(context);
        CGContextSetLineDash(context, CGFloat(0.0), nil, 0)//Remove the dash
        
        //Draw the bars
        let maxBarWidth:Float = Float(constant.kDefaultGraphWidth - constant.kBarTop - constant.kBarHeight / 2);
        for var i = 0; i < self.foodImportants.count; i++ {
            let barX:Float =  Float (constant.kOffsetX);
            //let barY:Float = Float (constant.kBarTop) + maxBarheight - maxBarheight * data[i];
            let barY:Float = Float(constant.kOffsetY + constant.kStepY + i * constant.kStepY - constant.kBarHeight / 2);
            //let barHeight:Float = maxBarWidth * data[i];
            
            var barHeight:Float! = 0.0
            
            var value = self.foodImportants[i].value
            if (self.foodImportants[i].unit.lowercaseString == "mg") {
                
                barHeight =  value < 100 ? 0.1 : ((self.foodImportants[i].value/1000)*2)
            }
            
            else {
                barHeight = value <= 1 ? 0.1:   (self.foodImportants[i].value * 2)
            }
            
            let barRect:CGRect = CGRectMake(CGFloat(barX), CGFloat(barY),CGFloat(barHeight),CGFloat(constant.kBarHeight))
            self.drawBar(barRect, context: context, index:i)
        }
    }
    
    func drawBar (rect:CGRect, context:CGContextRef, index:Int) {
        
        CGContextBeginPath(context);
        
        //Prepare the resources for gradient drawing
        let componenets:[CGFloat] = [0.2314, 0.5686, 0.4, 1.0, 0.4727, 1.0, 0.8157, 1.0, 0.2392, 0.5686, 0.4118, 1.0];
        //let componenets:[CGFloat] = [169/100, 3/100, 41/100, 143/100, 2/100, 34/100, 109/100, 0/100, 25/100, 0.5686, 0.4118, 1.0];
        
        let locations:[CGFloat]  = [0.0, 0.33, 1.0]
        let size_t_num_locations = 3;
        
        let colorSpace = CGColorSpaceCreateDeviceRGB();
        let gradient = CGGradientCreateWithColorComponents(colorSpace, componenets, locations, size_t_num_locations)
        
        let startPoint = rect.origin;
        let endpoint = CGPointMake(rect.origin.x ,rect.origin.y + rect.size.height)
        
        //Draw y- axix point
        let important  = self.foodImportants[index] as struct_important
        let xValue:NSString = important.importantName
        let point = CGPointMake(self.frame.origin.x + 35, startPoint.y)
        xValue.drawWithBasePoint(point,  angle: CGFloat(0), font: constant.axisPoint_Font!)
        
        //Draw Bar value at the end of bar
        let barFloat = self.roundToNearestQuarter (Float(rect.size.width))
        let barValue:NSString = "\(barFloat)"
        barValue.drawWithBasePoint(CGPointMake(CGFloat(Float(rect.size.width) + Float(constant.kOffsetX) + Float(40)), CGFloat(Float(rect.origin.y) + Float(5))),  angle: CGFloat(0), font: constant.axisPoint_Font!)
        
        //Create The clipping Path
        CGContextBeginPath(context);
        CGContextSetGrayFillColor(context, 0.2, 0.7);
        CGContextMoveToPoint(context, CGRectGetMinX(rect), CGRectGetMinY(rect));
        CGContextAddLineToPoint(context, CGRectGetMaxX(rect), CGRectGetMinY(rect));
        CGContextAddLineToPoint(context, CGRectGetMaxX(rect), CGRectGetMaxY(rect));
        CGContextAddLineToPoint(context, CGRectGetMinX(rect), CGRectGetMaxY(rect));
        CGContextClosePath(context);
        
        CGContextSaveGState(context)
        CGContextClip(context)
        
        //Draw the Gradient
        CGContextDrawLinearGradient(context, gradient, startPoint, endpoint, 0);
        CGContextRestoreGState(context)
        
        CGContextFillPath(context);
    }

}

//Draw axix text
extension NSString {
    
    func drawWithBasePoint(basePoint:CGPoint, angle:CGFloat, font:UIFont) {
        
        var attrs: NSDictionary = [
            NSFontAttributeName: font
        ]
        
        var textSize:CGSize = self.sizeWithAttributes(attrs as [NSObject : AnyObject])
        
        var context: CGContextRef =   UIGraphicsGetCurrentContext()
        
        var t:CGAffineTransform   =   CGAffineTransformMakeTranslation(basePoint.x, basePoint.y)
        var r:CGAffineTransform   =   CGAffineTransformMakeRotation(angle)
        
        
        CGContextConcatCTM(context, t)
        CGContextConcatCTM(context, r)
        
        
        self.drawAtPoint(CGPointMake(-1 * textSize.width / 2, -1 * textSize.height / 2), withAttributes: attrs as [NSObject : AnyObject])
        
        CGContextConcatCTM(context, CGAffineTransformInvert(r))
        CGContextConcatCTM(context, CGAffineTransformInvert(t))
        
    }
}

