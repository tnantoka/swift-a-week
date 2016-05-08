import Cocoa

class HelloWorld: NSObject {
  let menu = NSMenu()

  func createStatusMenu() {
    let statusItem = NSStatusBar.systemStatusBar().statusItemWithLength(NSVariableStatusItemLength)
    statusItem.title = "Menu"
    statusItem.menu = menu

    addItem("Quit", #selector(quit))
  }

  func addItem(title: String, _ selector: Selector) {
    let item = NSMenuItem()
    item.title = title
    item.target = self
    item.action = selector
    menu.addItem(item)
  }

  func quit() {
    NSApp.terminate(self)
  }
}
NSApplication.sharedApplication()
let hello = HelloWorld()
hello.createStatusMenu() 
NSApp.run()
