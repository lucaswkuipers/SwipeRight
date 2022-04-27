import UIKit

final class MainView: UIView {
    private let possibleDirections: [UISwipeGestureRecognizer.Direction] = [.up, .down, .left, .right]

    private var currentDirection: UISwipeGestureRecognizer.Direction = .up

    private var isMeaning = false

    let currentDirectionLabel: UILabel = {
        let label = UILabel()
        label.text = "Up"
        return label
    }()

    let currentDirectionImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "arrow.up")
        return imageView
    }()

    let modeLabel: UILabel = {
        let label = UILabel()
        label.text = "Icon"
        return label
    }()

    let statusLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    init() {
        super.init(frame: .zero)

        setDirection()
        setupViewStyle()
        setupGestures()
        setupViewHierarchy()
        setupViewConstraints()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    @objc private func didSwipe(_ sender: UISwipeGestureRecognizer) {
        let direction = sender.direction

        if direction == currentDirection {
            print("Correct!")
            statusLabel.text = "Correct!"

            statusLabel.backgroundColor = .green
        } else {
            print("Wrong!")
            statusLabel.text = "Wrong!"
            statusLabel.backgroundColor = .red
        }

        print(direction.name)
        setDirection()
    }

    private func setupViewStyle() {
        backgroundColor = .red
    }

    private func setupGestures() {
        let swipeUpGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(didSwipe))
        let swipeDownGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(didSwipe))
        let swipeLeftGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(didSwipe))
        let swipeRightGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(didSwipe))

        addGestureRecognizer(swipeUpGestureRecognizer)
        addGestureRecognizer(swipeDownGestureRecognizer)
        addGestureRecognizer(swipeLeftGestureRecognizer)
        addGestureRecognizer(swipeRightGestureRecognizer)

        swipeUpGestureRecognizer.direction = .up
        swipeDownGestureRecognizer.direction = .down
        swipeLeftGestureRecognizer.direction = .left
        swipeRightGestureRecognizer.direction = .right
    }

    private func setupViewHierarchy() {
        addSubview(currentDirectionLabel)
        addSubview(currentDirectionImageView)
        addSubview(modeLabel)
        addSubview(statusLabel)
    }

    private func setupViewConstraints() {
        subviews.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }

        NSLayoutConstraint.activate([
            currentDirectionLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            currentDirectionLabel.centerYAnchor.constraint(equalTo: centerYAnchor),

            currentDirectionImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            currentDirectionImageView.topAnchor.constraint(equalTo: currentDirectionLabel.bottomAnchor),

            modeLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            modeLabel.centerXAnchor.constraint(equalTo: centerXAnchor),

            statusLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            statusLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }

    private func setDirection() {
        isMeaning = Bool.random()

        backgroundColor = isMeaning ? .red : .green

        let shouldChangeDirection = Bool.random()
        guard shouldChangeDirection else { return }

        guard let newWrittenDirection = possibleDirections.randomElement() else { return }
        currentDirectionLabel.text = "\(currentDirection.name)"

        guard let newIconDirection = possibleDirections.randomElement() else { return }
        currentDirectionImageView.image = UIImage(systemName: "arrow.\(newIconDirection.name)")

        currentDirection = isMeaning ? newWrittenDirection : newIconDirection

        modeLabel.text = isMeaning ? "Written" : "Icon"
    }
}

extension UISwipeGestureRecognizer.Direction {
    var name: String {
        switch self {
        case .up:
            return "up"
        case .down:
            return "down"
        case .left:
            return "left"
        case .right:
            return "right"
        default:
            return ""
        }
    }
}
