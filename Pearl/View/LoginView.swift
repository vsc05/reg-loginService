import UIKit

class LoginView: UIViewController {
    // MARK: - Dependencies
    private var viewBuilder = ViewBuilder()
    private let service = AuthService()

    // MARK: - UI Elements
    private lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.showsVerticalScrollIndicator = false
        return scroll
    }()

    private lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 20
        stack.alignment = .fill
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    // Элементы создаем через твой viewBuilder
    lazy var titleLabel = viewBuilder.createLabel(frame: .zero, text: "Вход", size: 28)
    lazy var emailTextField = viewBuilder.createTextField(frame: .zero, placeholder: "Email")
    lazy var passwordTextField = viewBuilder.createTextField(frame: .zero, placeholder: "Password", isPassword: true)
    lazy var loginButton = viewBuilder.createFilledButton(frame: .zero, title: "Войти", action: loginAction)
    lazy var goBackButton = viewBuilder.createButton(frame: .zero, title: "Назад", action: goBackAction)

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupKeyboardHiding()
    }

    // MARK: - Setup
    private func setupUI() {
        view.backgroundColor = .white
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(stackView)

        // Добавляем элементы в стек
        [titleLabel, emailTextField, passwordTextField, loginButton, goBackButton].forEach {
            stackView.addArrangedSubview($0)
            
            // Фиксируем высоту для полей и кнопок (стандарт 50)
            if $0 is UITextField || $0 is UIButton {
                $0.heightAnchor.constraint(equalToConstant: 50).isActive = true
            }
        }
        
        // Кастомный отступ после заголовка и перед кнопкой логина
        stackView.setCustomSpacing(40, after: titleLabel)
        stackView.setCustomSpacing(100, after: passwordTextField)

        NSLayoutConstraint.activate([
            // ScrollView на весь экран
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            // ContentView привязан к ScrollView
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

            // StackView с отступами по бокам
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 40),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
    }

    // MARK: - Keyboard Management
    private func setupKeyboardHiding() {
        // Скрытие клавиатуры по тапу на экран
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)

        // Подписка на уведомления клавиатуры
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }

    @objc private func keyboardWillShow(notification: NSNotification) {
        guard let userInfo = notification.userInfo,
              let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        
        // Увеличиваем нижний отступ скролла, чтобы кнопки "всплыли" над клавиатурой
        let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardFrame.height - view.safeAreaInsets.bottom + 20, right: 0)
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }

    @objc private func keyboardWillHide() {
        scrollView.contentInset = .zero
        scrollView.scrollIndicatorInsets = .zero
    }

    // MARK: - Actions
    lazy var loginAction: UIAction = UIAction { [weak self] _ in
        guard let self = self else { return }
        self.viewBuilder.animateButton(self.loginButton)
        
        let email = self.emailTextField.text ?? ""
        let password = self.passwordTextField.text ?? ""
        
        let user = UserData(email: email, password: password)
        self.service.signIn(user: user) { result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self.routeTo(target: WindowCase.home)
                case .failure(let error):
                    print("Login error: \(error)")
                }
            }
        }
    }

    lazy var goBackAction: UIAction = UIAction { [weak self] _ in
        self?.routeTo(target: WindowCase.reg)
    }

    private func routeTo(target: WindowCase) {
        NotificationCenter.default.post(
            name: Notification.Name("routeVC"),
            object: nil,
            userInfo: ["vc": target]
        )
    }
}
