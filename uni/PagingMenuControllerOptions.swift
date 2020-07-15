//
//  PagingMenuControllerOptions.swift
//  PagingMenuControllerDemo
//
//  Created by Yusuke Kita on 6/9/16.
//  Copyright © 2016 kitasuke. All rights reserved.
//

import Foundation
import PagingMenuController

struct MenuItemUsers: MenuItemViewCustomizable {}
struct MenuItemRepository: MenuItemViewCustomizable {}
struct MenuItemGists: MenuItemViewCustomizable {}

struct PagingMenuOptions1: PagingMenuControllerCustomizable {
    let usersViewController = UsersViewController.instantiateFromStoryboard()
    let repositoriesViewController = RepositoriesViewController.instantiateFromStoryboard()
    let gistsViewController = GistsViewController.instantiateFromStoryboard()

    
    var componentType: ComponentType {
        return .all(menuOptions: MenuOptions(), pagingControllers: [usersViewController, repositoriesViewController, gistsViewController])
    }
    var lazyLoadingPage: LazyLoadingPage {
        return .all
    }
    
    struct MenuOptions: MenuViewCustomizable {
        var displayMode: MenuDisplayMode {
            return .standard(widthMode: .flexible, centerItem: false, scrollingMode: .pagingEnabled)
        }
        var focusMode: MenuFocusMode {
            return .none
        }
        var height: CGFloat {
            return 60
        }
        var itemsOptions: [MenuItemViewCustomizable] {
            return [MenuItemUsers(), MenuItemRepository(), MenuItemGists()]
        }
    }
    
    struct MenuItemUsers: MenuItemViewCustomizable {
        var displayMode: MenuItemDisplayMode {
            let title = MenuItemText(text: "Users")
            return .text(title: title)
        }
    }
    struct MenuItemRepository: MenuItemViewCustomizable {
        var displayMode: MenuItemDisplayMode {
            let title = MenuItemText(text: "Repository")
            return .text(title: title)
        }
    }
    struct MenuItemGists: MenuItemViewCustomizable {
        var displayMode: MenuItemDisplayMode {
            let title = MenuItemText(text: "Gists")
            return .text(title: title)
        }
    }
}

struct PagingMenuOptions2: PagingMenuControllerCustomizable {
    let usersViewController = UsersViewController.instantiateFromStoryboard()
    let repositoriesViewController = RepositoriesViewController.instantiateFromStoryboard()
    let gistsViewController = GistsViewController.instantiateFromStoryboard()

    
    var componentType: ComponentType {
        return .all(menuOptions: MenuOptions(), pagingControllers: [usersViewController, repositoriesViewController, gistsViewController])
    }
    var menuControllerSet: MenuControllerSet {
        return .single
    }
    
    struct MenuOptions: MenuViewCustomizable {
        var displayMode: MenuDisplayMode {
            return .segmentedControl
        }
        var itemsOptions: [MenuItemViewCustomizable] {
            return [MenuItemUsers(), MenuItemRepository(), MenuItemGists()]
        }
    }
}

struct PagingMenuOptions3: PagingMenuControllerCustomizable {
    let usersViewController = UsersViewController.instantiateFromStoryboard()
    let repositoriesViewController = RepositoriesViewController.instantiateFromStoryboard()
    let gistsViewController = GistsViewController.instantiateFromStoryboard()

    
    var componentType: ComponentType {
        return .all(menuOptions: MenuOptions(), pagingControllers: [usersViewController, repositoriesViewController, gistsViewController])
    }
    var lazyLoadingPage: LazyLoadingPage {
        return .three
    }
    
    struct MenuOptions: MenuViewCustomizable {
        var displayMode: MenuDisplayMode {
            return .infinite(widthMode: .fixed(width: 80), scrollingMode: .scrollEnabled)
        }
        var itemsOptions: [MenuItemViewCustomizable] {
            return [MenuItemUsers(), MenuItemRepository(), MenuItemGists()]
        }
    }
}

struct PagingMenuOptions4: PagingMenuControllerCustomizable {
    var componentType: ComponentType {
        return .menuView(menuOptions: MenuOptions())
    }
    
    struct MenuOptions: MenuViewCustomizable {
        var displayMode: MenuDisplayMode {
            return .segmentedControl
        }
        var focusMode: MenuFocusMode {
            return .underline(height: 3, color: UIColor.blue, horizontalPadding: 10, verticalPadding: 0)
        }
        var itemsOptions: [MenuItemViewCustomizable] {
            return [MenuItemUsers(), MenuItemRepository(), MenuItemGists()]
        }
    }
}

struct PagingMenuOptions5: PagingMenuControllerCustomizable {
    var componentType: ComponentType {
        return .menuView(menuOptions: MenuOptions())
    }
    
    struct MenuOptions: MenuViewCustomizable {
        var displayMode: MenuDisplayMode {
            return .infinite(widthMode: .flexible, scrollingMode: .pagingEnabled)
        }
        var focusMode: MenuFocusMode {
            return .roundRect(radius: 12, horizontalPadding: 8, verticalPadding: 8, selectedColor: UIColor.lightGray)
        }
        var itemsOptions: [MenuItemViewCustomizable] {
            return [MenuItemUsers(), MenuItemRepository(), MenuItemGists()]
        }
    }
}

struct PagingMenuOptions6: PagingMenuControllerCustomizable {
    let usersViewController = UsersViewController.instantiateFromStoryboard()
    let repositoriesViewController = RepositoriesViewController.instantiateFromStoryboard()
    let gistsViewController = GistsViewController.instantiateFromStoryboard()

    
    var componentType: ComponentType {
        return .pagingController(pagingControllers: [usersViewController, repositoriesViewController, gistsViewController])
    }
    var defaultPage: Int {
        return 1
    }
}
