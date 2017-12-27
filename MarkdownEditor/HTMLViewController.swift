import Cocoa
import Down
import WebKit

class HTMLViewController: NSViewController {

    override func loadView() {
        view = try! DownView(frame: .zero, markdownString: "") {
            print("hello!")
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let center = NotificationCenter.default
        center.addObserver(forName: markdownTextDidChange, object: nil, queue: nil) { [unowned self] note in
            guard
                let mdtv = note.object as? NSTextView,
                let pv = self.view as? DownView
            else { return }

            do {
                let content = try mdtv.string.toHTML()
                let html = """
                ``` html
                \(content)
                ```
                """
                print(html)
                try pv.update(markdownString: html)
                
            } catch (let err) {
                print(err.localizedDescription)
            }
        }
    }
}
