//
// This is a generated file, do not edit!
// Generated by R.swift, see https://github.com/mac-cain13/R.swift
//

import Foundation
import Rswift
import UIKit

/// This `R` struct is generated and contains references to static resources.
struct R: Rswift.Validatable {
  fileprivate static let applicationLocale = hostingBundle.preferredLocalizations.first.flatMap(Locale.init) ?? Locale.current
  fileprivate static let hostingBundle = Bundle(for: R.Class.self)
  
  static func validate() throws {
    try intern.validate()
  }
  
  /// This `R.color` struct is generated, and contains static references to 0 color palettes.
  struct color {
    fileprivate init() {}
  }
  
  /// This `R.file` struct is generated, and contains static references to 0 files.
  struct file {
    fileprivate init() {}
  }
  
  /// This `R.font` struct is generated, and contains static references to 0 fonts.
  struct font {
    fileprivate init() {}
  }
  
  /// This `R.image` struct is generated, and contains static references to 0 images.
  struct image {
    fileprivate init() {}
  }
  
  /// This `R.nib` struct is generated, and contains static references to 0 nibs.
  struct nib {
    fileprivate init() {}
  }
  
  /// This `R.reuseIdentifier` struct is generated, and contains static references to 1 reuse identifiers.
  struct reuseIdentifier {
    /// Reuse identifier `IndexCell`.
    static let indexCell: Rswift.ReuseIdentifier<UIKit.UITableViewCell> = Rswift.ReuseIdentifier(identifier: "IndexCell")
    
    fileprivate init() {}
  }
  
  /// This `R.segue` struct is generated, and contains static references to 1 view controllers.
  struct segue {
    /// This struct is generated for `IndexViewController`, and contains static references to 2 segues.
    struct indexViewController {
      /// Segue identifier `NewNoteSegue`.
      static let newNoteSegue: Rswift.StoryboardSegueIdentifier<UIKit.UIStoryboardSegue, IndexViewController, UIKit.UINavigationController> = Rswift.StoryboardSegueIdentifier(identifier: "NewNoteSegue")
      /// Segue identifier `showDetailSegue`.
      static let showDetailSegue: Rswift.StoryboardSegueIdentifier<UIKit.UIStoryboardSegue, IndexViewController, NoteDetailViewController> = Rswift.StoryboardSegueIdentifier(identifier: "showDetailSegue")
      
      /// Optionally returns a typed version of segue `NewNoteSegue`.
      /// Returns nil if either the segue identifier, the source, destination, or segue types don't match.
      /// For use inside `prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)`.
      static func newNoteSegue(segue: UIKit.UIStoryboardSegue) -> Rswift.TypedStoryboardSegueInfo<UIKit.UIStoryboardSegue, IndexViewController, UIKit.UINavigationController>? {
        return Rswift.TypedStoryboardSegueInfo(segueIdentifier: R.segue.indexViewController.newNoteSegue, segue: segue)
      }
      
      /// Optionally returns a typed version of segue `showDetailSegue`.
      /// Returns nil if either the segue identifier, the source, destination, or segue types don't match.
      /// For use inside `prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)`.
      static func showDetailSegue(segue: UIKit.UIStoryboardSegue) -> Rswift.TypedStoryboardSegueInfo<UIKit.UIStoryboardSegue, IndexViewController, NoteDetailViewController>? {
        return Rswift.TypedStoryboardSegueInfo(segueIdentifier: R.segue.indexViewController.showDetailSegue, segue: segue)
      }
      
      fileprivate init() {}
    }
    
    fileprivate init() {}
  }
  
  /// This `R.storyboard` struct is generated, and contains static references to 2 storyboards.
  struct storyboard {
    /// Storyboard `LaunchScreen`.
    static let launchScreen = _R.storyboard.launchScreen()
    /// Storyboard `Main`.
    static let main = _R.storyboard.main()
    
    /// `UIStoryboard(name: "LaunchScreen", bundle: ...)`
    static func launchScreen(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.launchScreen)
    }
    
    /// `UIStoryboard(name: "Main", bundle: ...)`
    static func main(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.main)
    }
    
    fileprivate init() {}
  }
  
  /// This `R.string` struct is generated, and contains static references to 0 localization tables.
  struct string {
    fileprivate init() {}
  }
  
  fileprivate struct intern: Rswift.Validatable {
    fileprivate static func validate() throws {
      try _R.validate()
    }
    
    fileprivate init() {}
  }
  
  fileprivate class Class {}
  
  fileprivate init() {}
}

struct _R: Rswift.Validatable {
  static func validate() throws {
    try storyboard.validate()
  }
  
  struct nib {
    fileprivate init() {}
  }
  
  struct storyboard: Rswift.Validatable {
    static func validate() throws {
      try main.validate()
    }
    
    struct launchScreen: Rswift.StoryboardResourceWithInitialControllerType {
      typealias InitialController = UIKit.UIViewController
      
      let bundle = R.hostingBundle
      let name = "LaunchScreen"
      
      fileprivate init() {}
    }
    
    struct main: Rswift.StoryboardResourceWithInitialControllerType, Rswift.Validatable {
      typealias InitialController = UIKit.UINavigationController
      
      let bundle = R.hostingBundle
      let indexViewController = StoryboardViewControllerResource<IndexViewController>(identifier: "IndexViewController")
      let name = "Main"
      let newNoteNavController = StoryboardViewControllerResource<UIKit.UINavigationController>(identifier: "NewNoteNavController")
      let newNoteViewController = StoryboardViewControllerResource<NewNoteViewController>(identifier: "NewNoteViewController")
      
      func indexViewController(_: Void = ()) -> IndexViewController? {
        return UIKit.UIStoryboard(resource: self).instantiateViewController(withResource: indexViewController)
      }
      
      func newNoteNavController(_: Void = ()) -> UIKit.UINavigationController? {
        return UIKit.UIStoryboard(resource: self).instantiateViewController(withResource: newNoteNavController)
      }
      
      func newNoteViewController(_: Void = ()) -> NewNoteViewController? {
        return UIKit.UIStoryboard(resource: self).instantiateViewController(withResource: newNoteViewController)
      }
      
      static func validate() throws {
        if _R.storyboard.main().newNoteViewController() == nil { throw Rswift.ValidationError(description:"[R.swift] ViewController with identifier 'newNoteViewController' could not be loaded from storyboard 'Main' as 'NewNoteViewController'.") }
        if _R.storyboard.main().newNoteNavController() == nil { throw Rswift.ValidationError(description:"[R.swift] ViewController with identifier 'newNoteNavController' could not be loaded from storyboard 'Main' as 'UIKit.UINavigationController'.") }
        if _R.storyboard.main().indexViewController() == nil { throw Rswift.ValidationError(description:"[R.swift] ViewController with identifier 'indexViewController' could not be loaded from storyboard 'Main' as 'IndexViewController'.") }
      }
      
      fileprivate init() {}
    }
    
    fileprivate init() {}
  }
  
  fileprivate init() {}
}
