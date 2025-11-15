//
//  PageViewController.swift
//  Landmarks
//
//  Created by とりあえず読書会 on 2025/09/27.
//

import SwiftUI

struct PageViewController<Page: View>: UIViewControllerRepresentable {
    
    let pages: [Page]
    
    @Binding private(set) var currentPageNumber: PageNumber
    
    init(pages: some Sequence<Page>, currentPageNumber pageNumber: Binding<PageNumber>) {
        self.init(pages: Array(pages), currentPageNumber: pageNumber)
    }
    
    init(pages: [Page], currentPageNumber: Binding<PageNumber>) {
        precondition(!pages.isEmpty, "Page は１つ以上指定する必要があります。")

        self.pages = pages
        self._currentPageNumber = currentPageNumber
    }
    
    func makeCoordinator() -> Coordinator {
        let coordinator = Coordinator(owner: self)

        precondition(coordinator.pageNumberRange.contains(currentPageNumber), "指定した現在ページが、想定するページの範囲内にありません: ")
        
        return coordinator
    }
    
    func makeUIViewController(context: Context) -> UIPageViewController {
        let pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)

        pageViewController.dataSource = context.coordinator
        pageViewController.delegate = context.coordinator
        
        return pageViewController
    }
    
    func updateUIViewController(_ pageViewController: UIPageViewController, context: Context) {
        context.coordinator.owner = self
        
        let controller = context.coordinator.currentPageController
        pageViewController.setViewControllers([controller], direction: .forward, animated: true)
    }
}

extension PageViewController {
    
    fileprivate typealias PageController = UIHostingController<Page>
    
    @MainActor
    final class Coordinator: NSObject, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
        
        fileprivate var owner: PageViewController
        fileprivate let pageControllers: [PageController]
        
        fileprivate init(owner: PageViewController) {
            self.owner = owner
            self.pageControllers = owner.pages
                .map(PageController.init(rootView:))
        }
        
        func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
            guard let pageNumber = pageNumber(for: viewController) else {
                return nil
            }
                    
            switch pageNumber {
            case startPageNumber:
                return pageController(for: lastPageNumber)
                
            default:
                return pageController(for: pageNumber.previous)
            }
        }
        
        func pageViewController(
            _ pageViewController: UIPageViewController,
            viewControllerAfter viewController: UIViewController) -> UIViewController?
        {
            guard let pageNumber = pageNumber(for: viewController) else {
                return nil
            }
            
            switch pageNumber.next {
            case endPageNumber:
                return pageController(for: startPageNumber)
                
            case let nextPageNumber:
                return pageController(for: nextPageNumber)
            }
        }
        
        func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
            guard completed else {
                return
            }
            
            guard let visibleViewController = pageViewController.viewControllers?.first else {
                return
            }
            
            guard let pageNumber = pageNumber(for: visibleViewController) else {
                fatalError("予期しない Page View Controller が表示されていました: \(visibleViewController)")
            }
            
            owner.currentPageNumber = pageNumber
        }
    }
}

private extension PageViewController.Coordinator {
    
    typealias PageController = PageViewController.PageController
    
    var startPageNumber: PageNumber {
        pageNumber(fromIndex: pageControllers.startIndex)
    }
    
    var endPageNumber: PageNumber {
        pageNumber(fromIndex: pageControllers.endIndex)
    }
    
    var lastPageNumber: PageNumber {
        endPageNumber.previous
    }
    
    var pageNumberRange: Range<PageNumber> {
        startPageNumber ..< endPageNumber
    }
    
    func index(from pageNumber: PageNumber) -> Int {
        pageControllers.index(pageControllers.startIndex, offsetBy: pageNumber.offset)
    }
    
    func pageNumber(fromIndex index: Int) -> PageNumber {
        let distance = pageControllers.distance(from: pageControllers.startIndex, to: index)
        return PageNumber.start + distance
    }

    func pageNumber(for pageController: UIViewController) -> PageNumber? {
        guard let pageController = pageController as? PageController else {
            return nil
        }
        
        return pageNumber(for: pageController)
    }
    
    func pageNumber(for pageController: PageController) -> PageNumber? {
        pageControllers
            .firstIndex(of: pageController)
            .map(pageNumber(fromIndex:))
    }
    
    func pageController(for pageNumber: PageNumber) -> PageController? {
        let controllerIndex = index(from: pageNumber)
        
        guard pageControllers.indices.contains(controllerIndex) else {
            return nil
        }
        
        return pageControllers[controllerIndex]
    }
    
    var currentPageController: PageController {
        let currentPageNumber = owner.currentPageNumber
        
        guard let controller = pageController(for: currentPageNumber) else {
            fatalError("現在ページを制御するコントローラが見つかりません: \(currentPageNumber)")
        }
        
        return controller
    }
}
