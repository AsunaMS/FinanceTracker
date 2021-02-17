//
//  ArticleTableViewCell.swift
//  FinanceTracker
//
//  Created by נדב אבנון on 14/02/2021.
//

import UIKit

class ArticleTableViewCell: UITableViewCell {

    @IBOutlet weak var articleImage: UIImageView!
    
    @IBOutlet weak var articleAuthor: UILabel!
    
    @IBOutlet weak var articleDate: UILabel!
    @IBOutlet weak var articleTitle: UILabel!
    @IBOutlet weak var articleContent: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func populate(article:Article) {
        articleImage.image = UIImage(systemName: "photo")
        if let author  = article.author {
            articleAuthor?.text = "Author:"
            articleAuthor?.text! += " \(author)"
        }
        if let title = article.title {
            articleTitle?.text = title
        }
        if let content = article.description {
            articleContent?.backgroundColor = UIColor.clear
            articleContent?.text = content
        }
        if let date = article.publishedAt {
            articleDate?.text = "Published:"
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ssZZZ"
            let date = dateFormatter.date(from: date)!
            let formattedDate = UIUtils.getFormattedDateString(for: date, dateStyle: .long)
            articleDate?.text! += " \(formattedDate)"
        }
        if let imageurl = article.urlToImage {
            
            guard let url = URL(string: imageurl) else {return}
            guard let imagedata = try? Data(contentsOf: url) else {return}
            guard let image = UIImage(data: imagedata) else {return}
            articleImage?.layer.cornerRadius = 8
            articleImage?.layer.borderWidth = 1
            articleImage?.contentMode = .scaleAspectFill
            articleImage?.sizeToFit()
            articleImage?.clipsToBounds = true
            layer.masksToBounds = true
            articleImage?.layer.borderColor = UIColor.black.cgColor
            articleImage?.image = image
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
