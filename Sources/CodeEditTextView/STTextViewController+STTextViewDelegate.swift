//
//  STTextViewController+STTextViewDelegate.swift
//  CodeEditTextView
//
//  Created by Lukas Pistrol on 28.05.22.
//

import AppKit
import STTextView

extension STTextViewController {
    
    
    public override func viewWillAppear() {
        super.viewWillAppear()
        NSEvent.addLocalMonitorForEvents(matching: .keyDown, handler: doTabKey(event:))
        
    }
    
    public func textDidChange(_ notification: Notification) {
        print("Text did change")
    }

    public func textView(
        _ textView: STTextView,
        shouldChangeTextIn affectedCharRange: NSTextRange,
        replacementString: String?
    ) -> Bool {
        // Don't add '\t' characters
        if replacementString == "\t" {
            return false
        }
        return true
    }

    public func textView(
        _ textView: STTextView,
        didChangeTextIn affectedCharRange: NSTextRange,
        replacementString: String
    ) {
        textView.autocompleteBracketPairs(replacementString)
        print("Did change text in \(affectedCharRange) | \(replacementString)")
        highlight()
        setStandardAttributes()
        self.text.wrappedValue = textView.string
        
//        if event.specialKey == .tab {
//            textView?.insertText(String(repeating: " ", count: tabWidth))
//        }
        
    }
    
    private func doTabKey(event: NSEvent) -> NSEvent {
        if event.specialKey == .tab {
            textView?.insertText(String(repeating: " ", count: tabWidth))
        }
        
        return event
    }
}
