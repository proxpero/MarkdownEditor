import Cocoa
import Down

class PreviewController: NSViewController {

    override func loadView() {
        view = try! DownView(frame: .zero, markdownString: " ")
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
                let html = try mdtv.string.toHTML()
                try pv.update(markdownString: html)
            } catch (let err) {
                print(err.localizedDescription)
            }
        }
    }
}
