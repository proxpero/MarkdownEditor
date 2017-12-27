import Cocoa
import Down

let markdownTextDidChange = Notification.Name(rawValue: "com.proxpero.markdownTextDidChangeNotification")

public class MarkdownViewController: NSViewController {

    @IBOutlet var textView: NSTextView!

    public override func viewDidLoad() {
        super.viewDidLoad()
        textView.textContainerInset = NSSize(width: 14, height: 14)
        textView.font = NSFont(name: "Menlo", size: 14)
    }

}

extension MarkdownViewController: NSTextViewDelegate {

    public func textDidChange(_ notification: Notification) {
        let center = NotificationCenter.default
        center.post(name: markdownTextDidChange, object: textView)
    }

}
