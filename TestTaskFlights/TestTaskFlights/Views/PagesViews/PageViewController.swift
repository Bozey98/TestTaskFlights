//
//  PageViewController.swift
//  ZhekaTask
//
//  Created by Денис Мусатов on 30.10.2020.
//

import SwiftUI

struct PageViewController: UIViewControllerRepresentable {
    
    @Binding var number: Int
    
    @State var controllers: [UIViewController]
    
    func makeUIViewController(context: Context) -> UIPageViewController {
        
        let pageView = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        
        pageView.delegate = context.coordinator
        pageView.dataSource = context.coordinator
        
        return pageView
    }
    
    func updateUIViewController(_ uiViewController: UIPageViewController, context: Context) {
        if let current = uiViewController.viewControllers?.first,
           let index = controllers.firstIndex(of: current)
           {
            uiViewController.setViewControllers([controllers[number]], direction: number > index ? .forward : .reverse, animated: true, completion: nil)
        } else {
            uiViewController.setViewControllers([controllers[number]], direction: .forward, animated: true, completion: nil)
        }
        

        
        
        
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UIPageViewControllerDelegate, UIPageViewControllerDataSource {
        let parent: PageViewController
        
        init(_ parent: PageViewController) {
            self.parent = parent
        }
        
        func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
            guard let index = parent.controllers.firstIndex(of: viewController) else {
                return nil}
            if index == 0 {
                return parent.controllers.last
            }
            
            return parent.controllers[index - 1]
        }
        
        func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
            guard let index = parent.controllers.firstIndex(of: viewController) else { return nil}
            if index == parent.controllers.count - 1 {
                return parent.controllers.first
            }
            
            return parent.controllers[index + 1]
        }
        
        func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
            if finished,
               let visibleViewController = pageViewController.viewControllers?.first,
               let index = parent.controllers.firstIndex(of: visibleViewController) {
                parent.number = index
            }
        }
    }
}

struct PageViewController_Previews: PreviewProvider {
    static var previews: some View {
        PageViewController(number: .constant(1), controllers: [])
    }
}
