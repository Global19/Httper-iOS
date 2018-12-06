//
//  PrettyViewController.swift
//  Httper
//
//  Created by Meng Li on 09/12/2016.
//  Copyright © 2016 MuShare Group. All rights reserved.
//

import UIKit
import MGFormatter
import RxSwift

fileprivate struct Const {
    static let margin = 5
}

class PrettyViewController: UIViewController {
    
    private lazy var formatterView = FormatterView()
    
    private let viewModel: PrettyViewModel
    
    init(viewModel: PrettyViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(formatterView)
        createConstraints()
        
        Observable.combineLatest(viewModel.text, viewModel.style).subscribe(onNext: { [unowned self] (text, style) in
            self.formatterView.format(string: text, style: style)
        }).disposed(by: disposeBag)
    }
    
    private func createConstraints() {
        formatterView.snp.makeConstraints {
            $0.left.equalToSuperview().offset(Const.margin)
            $0.right.equalToSuperview().offset(Const.margin)
            $0.top.bottom.equalToSuperview()
        }
    }
    
}