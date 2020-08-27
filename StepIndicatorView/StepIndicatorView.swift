
//
//  StepIndicatorView.swift
//  PaycellUIKit
//
//  Created by OZNUR AKGUN on 1.04.2020.
//  Copyright © 2020 BARAN BATUHAN KARAOGUZ. All rights reserved.
//

import UIKit
import PaycellCore

public protocol StepIndicatorViewDataSource: class {
    func stepIndicatorViewModel() -> [StepIndicatorViewModel]
}

public final class StepIndicatorView: UIView {
    public weak var dataSource: StepIndicatorViewDataSource?
    var step = 0
    let viewModel = StepIndicatorViewAttribute()
    
    public func setStepNumber(step: Int) {
        self.step = step
        reloadData()
    }
    
    func reloadData() {
        removeSubViews()
        setup()
    }
        
    func setup() {
        backgroundColor = .getWhite
        translatesAutoresizingMaskIntoConstraints = false
        
        let lineView = createLineView()
        let bulletStackView = hStack(alignment: .center, distribution: .equalCentering)(createBulletViews())
            .applyMargins(top: viewModel.bulletStackViewMargins.top,
                          leading: viewModel.bulletStackViewMargins.leading,
                          bottom: viewModel.bulletStackViewMargins.bottom,
                          trailing: viewModel.bulletStackViewMargins.trailing)
        
        with(bulletStackView) {
            addSubview($0)
            $0.insertSubview(lineView, at: 0)
            
            NSLayoutConstraint.activate([
                $0.topAnchor.constraint(equalTo: self.topAnchor),
                $0.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                $0.trailingAnchor.constraint(equalTo: self.trailingAnchor),
                $0.heightAnchor.constraint(equalToConstant: viewModel.bulletStackViewHeight),
                
                lineView.topAnchor.constraint(equalTo: self.topAnchor, constant: 32),
                lineView.leadingAnchor.constraint(equalTo: $0.leadingAnchor, constant: viewModel.lineView.leading),
                lineView.trailingAnchor.constraint(equalTo: $0.trailingAnchor, constant: viewModel.lineView.trailing),
                lineView.heightAnchor.constraint(equalToConstant: viewModel.lineView.height)
            ])
        }
        
        let labelStact = hStack(alignment: .top, distribution: .fillEqually)(createVerticalLabelStactView())
        with(labelStact) {
            addSubview($0)
            NSLayoutConstraint.activate([
                $0.topAnchor.constraint(equalTo: bulletStackView.bottomAnchor, constant: 5),
                $0.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                $0.trailingAnchor.constraint(equalTo: self.trailingAnchor),
                $0.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            ])
        }
    }
    
    func getState(index: Int) -> StepIndicatorViewState {
        if index < step {
            
            return .done
        } else if index == step {
            
            return .inProgress
        } else {
            
            return .todo
        }
    }

    func removeSubViews() {
        subviews.forEach({
            $0.removeFromSuperview()
        })
    }
}

extension StepIndicatorView {
    func createBulletViews() -> [UIView] {
        var bulletViews = [UIView]()
        dataSource?.stepIndicatorViewModel().enumerated().forEach { (index, model) in
            switch getState(index: index) {
            case .todo:
                bulletViews.append(createTodoBulletView())
            case .inProgress:
                bulletViews.append(createInProgressBulletView(index: index + 1))
            case .done:
                bulletViews.append(createDoneBulletView())
            }
        }
        
        return bulletViews
    }
    
    func createDoneBulletView() -> UIView {
        with(UIImageView(image: UIImage.getImage(with: "success"))) {
            $0.backgroundColor = viewModel.doneBulletColor
            $0.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                $0.widthAnchor.constraint(equalToConstant: viewModel.doneBullet.width),
                $0.heightAnchor.constraint(equalToConstant: viewModel.doneBullet.height)
            ])
        }
    }
    
    func createTodoBulletView() -> UIView {
        with(UIView(frame: .zero)){
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.backgroundColor = viewModel.todoBulletColor
            $0.layer.cornerRadius = viewModel.todoBulletRadius
            NSLayoutConstraint.activate([
                $0.widthAnchor.constraint(equalToConstant: viewModel.todoBullet.width),
                $0.heightAnchor.constraint(equalToConstant: viewModel.todoBullet.height)
            ])
        }
    }
    
    func createInProgressBulletView(index: Int) -> UIView {
        let view = UIView(frame: .zero)
        view.backgroundColor = viewModel.inProgressBulletColor
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = viewModel.inProgressBulletRadius
        
        NSLayoutConstraint.activate([
            view.widthAnchor.constraint(equalToConstant: viewModel.inProgressBullet.width),
            view.heightAnchor.constraint(equalToConstant: viewModel.inProgressBullet.height)
        ])
        
        let label = Label(fontSize: .body)
        label.setText(text: "\(index)")
        label.setFontWeight(type: .bold)
        label.setTextColor(color: .white)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.resetAllPadding()
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.widthAnchor.constraint(equalToConstant: viewModel.inProgressLabel.width),
            label.heightAnchor.constraint(equalToConstant: viewModel.inProgressLabel.height),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        return view
    }
    
    func createLineView() -> UIView {
        with(UIView(frame: .zero)) {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.backgroundColor = viewModel.todoBulletColor
        }
    }
    
    func createVerticalLabelStactView() -> [UIView] {
        var view = [UIView]()
        dataSource?.stepIndicatorViewModel().enumerated().forEach({ (index, model) in
            var labelStackView = [UIView]()
            labelStackView.append(with(Label(fontSize: .caption3)) {
                $0.setText(text: model.title)
                $0.translatesAutoresizingMaskIntoConstraints = false
                $0.setAlignment(alignment: .center)
                $0.resetAllPadding()
                
                if getState(index: index) == .inProgress {
                    $0.setTextColor(color: viewModel.inProgressLabelColor)
                } else {
                    $0.setTextColor(color: viewModel.doneAndTodoLabelColor)
                }
            })
            
            if let desc = model.desc,
                getState(index: index) != .todo {
                labelStackView.append(with(Label(fontSize: .caption3)) {
                    $0.setText(text: desc)
                    $0.translatesAutoresizingMaskIntoConstraints = false
                    $0.setAlignment(alignment: .center)
                    $0.resetAllPadding()
                    $0.setTextColor(color: viewModel.doneAndTodoLabelColor)
                    $0.setFontWeight(type: .bold)
                })
            }
            
            view.append(vStack()(labelStackView))
        })
        
        return view
    }
}
