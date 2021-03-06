//
//  MeetingsTableViewCell.swift
//  hugoChallenge
//
//  Created by Vitor Spessoto on 24/04/21.
//

import UIKit

class MeetingsTableViewCell: UITableViewCell {
    //*************************************************
    // MARK: - UI Shared Components
    //*************************************************
    private let titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.configure(style: .title, color: .black)
        lbl.textAlignment = .left
        return lbl
    }()
    
    private let detailsLabel: UILabel = {
        let lbl = UILabel()
        lbl.configure(style: .legend, color: .blue)
        lbl.textAlignment = .left
        return lbl
    }()
    
    private let todayLabel: UILabel = {
        let lbl = UILabel()
        lbl.configure(style: .legendTitle, color: .green)
        lbl.textAlignment = .right
        return lbl
    }()
    
    //*************************************************
    // MARK: - Properties
    //*************************************************
    static let identifier = "MeetingsTableViewCell"
    
    var title: String = ""
    var details: (String, String) = ("", "")
    
    //*************************************************
    // MARK: - lifecycle
    //*************************************************
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    //*************************************************
    // MARK: - Init
    //*************************************************
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    convenience init(title: String, details: (String, String)) {
        self.init()
        self.title = title
        self.details = details
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //*************************************************
    // MARK: - Private methods
    //*************************************************
    func setupUI() {
        titleLabel.text = title
        detailsLabel.text = details.0
        todayLabel.text = details.1
        
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(detailsLabel)
        self.contentView.addSubview(todayLabel)
        
        titleLabel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, rigth: nil,
                          paddingTop: 5, paddingLeft: 5, paddingBottom: 5, paddingRigth: 0,
                          width: frame.size.width, heigth: 0,
                          enableInsets: false)
        
        detailsLabel.anchor(top: titleLabel.bottomAnchor, left: leftAnchor, bottom: nil, rigth: nil,
                            paddingTop: 5, paddingLeft: 5, paddingBottom: 0, paddingRigth: 0,
                            width: frame.size.width, heigth: 0,
                            enableInsets: false)
        
        todayLabel.anchor(top: topAnchor, left: nil, bottom: nil, rigth: rightAnchor,
                          paddingTop: 5, paddingLeft: 0, paddingBottom: 0, paddingRigth: 5,
                          width: frame.size.width/3, heigth: 0,
                          enableInsets: false)
    }
    
}
