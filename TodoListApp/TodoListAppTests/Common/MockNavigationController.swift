//
//  MockNavigationController.swift
//  TodoListAppTests
//
//  Created by Elias Gabriel on 13/08/22.
//

import UIKit
@testable import TodoListApp

final class MockNavigationController: UINavigationController {
    var pushedVC: UIViewController?
    var popedVC: UIViewController?
    var presentedVC: UIViewController?
    var setableViewControllers: [UIViewController] = []
    var popViewControllerWasCalled: Bool = false
    var popToViewController: Bool = false
    var popToRootViewControllerWasCalled: Bool = false
    var dismissWasCalled: Bool = false
    var setViewControllerWasCalled: Bool = false
    
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        pushedVC = viewController
        super.pushViewController(viewController, animated: animated)
    }
    
    override func popViewController(animated: Bool) -> UIViewController? {
        popViewControllerWasCalled = true
        return nil
    }
    
    override func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
        presentedVC = viewControllerToPresent
        super.present(viewControllerToPresent, animated: flag, completion: completion)
    }
    
    override func popToViewController(_ viewController: UIViewController, animated: Bool) -> [UIViewController]? {
        popedVC = viewController
        popToViewController = true
        return nil
    }
    
    override func popToRootViewController(animated: Bool) -> [UIViewController]? {
        popToRootViewControllerWasCalled = true
        return nil
    }
    
    override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        dismissWasCalled = true
        super.dismiss(animated: flag, completion: completion)
    }
    
    override func setViewControllers(_ viewControllers: [UIViewController], animated: Bool) {
        setViewControllerWasCalled = true
        setableViewControllers = viewControllers
        super.setViewControllers(viewControllers, animated: animated)
    }
}
