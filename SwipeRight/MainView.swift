import UIKit

final class MainView: UIView {
    private let possibleDirections: [UISwipeGestureRecognizer.Direction] = [.up, .down, .left, .right]

    private var currentDirection: UISwipeGestureRecognizer.Direction = .up {
        didSet {
            currentDirectionLabel.text = "\(currentDirection.name)"
        }
    }

    let currentDirectionLabel: UILabel = {
        let label = UILabel()
        label.text = "Up"
        return label
    }()

    init() {
        super.init(frame: .zero)

        setNewDirection()
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
        } else {
            print("Wrong!")
        }

        print(direction.name)

        setNewDirection()
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
    }

    private func setupViewConstraints() {
        subviews.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }

        NSLayoutConstraint.activate([
            currentDirectionLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            currentDirectionLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }

    private func setNewDirection() {
        let shouldChangeDirection = Bool.random()
        guard shouldChangeDirection else { return }

        guard let newDirection = possibleDirections.randomElement() else { return }
        currentDirection = newDirection
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
