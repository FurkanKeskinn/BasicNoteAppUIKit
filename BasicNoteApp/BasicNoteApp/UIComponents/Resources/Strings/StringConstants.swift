// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
public enum L10n {
  public enum Error {
    /// Your email address should contain @.
    public static let emailInvalid = L10n.tr("Error", "emailInvalid", fallback: "Your email address should contain @.")
    /// Error.strings
    ///   BasicNoteApp
    /// 
    ///   Created by Furkan on 11.07.2023.
    public static let passwordInvalid = L10n.tr("Error", "passwordInvalid", fallback: "Password Invalid")
  }
  public enum General {
    /// Add Note
    public static let addNote = L10n.tr("General", "addNote", fallback: "Add Note")
    /// General.strings
    ///   BasicNoteApp
    /// 
    ///   Created by Furkan on 11.07.2023.
    public static let login = L10n.tr("General", "login", fallback: "Login")
    /// Ok
    public static let ok = L10n.tr("General", "ok", fallback: "Ok")
    /// Sign Up
    public static let register = L10n.tr("General", "register", fallback: "Sign Up")
    /// Reset Password
    public static let resetPassword = L10n.tr("General", "resetPassword", fallback: "Reset Password")
    /// Save
    public static let save = L10n.tr("General", "save", fallback: "Save")
    /// Save Note
    public static let saveNote = L10n.tr("General", "saveNote", fallback: "Save Note")
    /// Sign In Now
    public static let signInNow = L10n.tr("General", "signInNow", fallback: "Sign In Now")
    /// Sign Up Now
    public static let signUpNow = L10n.tr("General", "signUpNow", fallback: "Sign Up Now")
  }
  public enum Modules {
    /// Modules.strings
    ///   BasicNoteApp
    /// 
    ///   Created by Furkan on 11.07.2023.
    public static let descriptionText = L10n.tr("Modules", "descriptionText", fallback: "Login or sign up to continue using our app.")
    /// Forgot Password?
    public static let forgotPassword = L10n.tr("Modules", "forgotPassword", fallback: "Forgot Password?")
    /// %@ Note
    public static func noteTitle(_ p1: Any) -> String {
      return L10n.tr("Modules", "noteTitle", String(describing: p1), fallback: "%@ Note")
    }
    public enum ChangePasswordViewController {
      /// Change Password
      public static let changePassword = L10n.tr("Modules", "ChangePasswordViewController.changePassword", fallback: "Change Password")
      /// Sign Out
      public static let signOut = L10n.tr("Modules", "ChangePasswordViewController.signOut", fallback: "Sign Out")
      /// Change Password
      public static let title = L10n.tr("Modules", "ChangePasswordViewController.title", fallback: "Change Password")
      /// An email has been sent to %@ with further instructions.
      public static func toastMessage(_ p1: Any) -> String {
        return L10n.tr("Modules", "ChangePasswordViewController.toastMessage", String(describing: p1), fallback: "An email has been sent to %@ with further instructions.")
      }
    }
    public enum ForgotPasswordViewController {
      /// Confirm your email and we’ll send the instructions.
      public static let descriptionText = L10n.tr("Modules", "ForgotPasswordViewController.descriptionText", fallback: "Confirm your email and we’ll send the instructions.")
    }
    public enum LoginViewController {
      /// New User?
      public static let bottomText = L10n.tr("Modules", "LoginViewController.bottomText", fallback: "New User?")
      /// Login
      public static let title = L10n.tr("Modules", "LoginViewController.title", fallback: "Login")
      /// The email and password you entered did notmatch our records. Please try again.
      public static let toastMessage = L10n.tr("Modules", "LoginViewController.toastMessage", fallback: "The email and password you entered did notmatch our records. Please try again.")
    }
    public enum ProfileViewController {
      /// Change Password
      public static let changePassword = L10n.tr("Modules", "ProfileViewController.changePassword", fallback: "Change Password")
      /// Sign Out
      public static let signOut = L10n.tr("Modules", "ProfileViewController.signOut", fallback: "Sign Out")
      /// Profile
      public static let title = L10n.tr("Modules", "ProfileViewController.title", fallback: "Profile")
      /// The fullname or email you entered did notmatch our records. Please try again.
      public static let toastMessage = L10n.tr("Modules", "ProfileViewController.toastMessage", fallback: "The fullname or email you entered did notmatch our records. Please try again.")
    }
    public enum RegisterViewController {
      /// Already have an account?
      public static let bottomText = L10n.tr("Modules", "RegisterViewController.bottomText", fallback: "Already have an account?")
      /// Sign Up
      public static let title = L10n.tr("Modules", "RegisterViewController.title", fallback: "Sign Up")
    }
  }
  public enum Placeholder {
    /// Description
    public static let description = L10n.tr("Placeholder", "description", fallback: "Description")
    /// Email Address
    public static let email = L10n.tr("Placeholder", "email", fallback: "Email Address")
    /// Placeholder.strings
    ///   BasicNoteApp
    /// 
    ///   Created by Furkan on 11.07.2023.
    public static let fullname = L10n.tr("Placeholder", "fullname", fallback: "Full Name")
    /// New Password
    public static let newPassword = L10n.tr("Placeholder", "newPassword", fallback: "New Password")
    /// Password
    public static let password = L10n.tr("Placeholder", "password", fallback: "Password")
    /// Retype New Password
    public static let retypeNewPassword = L10n.tr("Placeholder", "retypeNewPassword", fallback: "Retype New Password")
    /// Search...
    public static let search = L10n.tr("Placeholder", "search", fallback: "Search...")
    /// Title
    public static let title = L10n.tr("Placeholder", "title", fallback: "Title")
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: value, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
