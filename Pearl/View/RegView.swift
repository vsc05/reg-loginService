import UIKit

class RegView: UIViewController {
    // MARK: - Dependencies
    private var viewBuilder = ViewBuilder()
    private let service = AuthService()

    // MARK: - UI Components
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
        stack.spacing = 18
        stack.alignment = .fill
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    // Элементы интерфейса
    lazy var titleLabel = viewBuilder.createLabel(frame: .zero, text: "Регистрация", size: 28)
    lazy var emailTextField = viewBuilder.createTextField(frame: .zero, placeholder: "Email")
    lazy var passwordTextField = viewBuilder.createTextField(frame: .zero, placeholder: "Пароль", isPassword: true)
    lazy var nameTextField = viewBuilder.createTextField(frame: .zero, placeholder: "Имя")
    
    lazy var registerButton = viewBuilder.createFilledButton(frame: .zero, title: "Зарегистрироваться", action: registerAction)
    lazy var hasAccountButton = viewBuilder.createButton(frame: .zero, title: "Уже есть аккаунт?", action: toLoginAction)

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupKeyboardHiding()
    }

    // MARK: - UI Setup
    private func setupUI() {
        view.backgroundColor = .white
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(stackView)

        // Добавляем все элементы в вертикальный стек
        [titleLabel, emailTextField, passwordTextField, nameTextField, registerButton, hasAccountButton].forEach {
            stackView.addArrangedSubview($0)
            
            // Задаем высоту для интерактивных элементов
            if $0 is UITextField || $0 is UIButton {
                $0.heightAnchor.constraint(equalToConstant: 50).isActive = true
            }
        }
        
        // Настраиваем кастомные отступы для красоты
        stackView.setCustomSpacing(40, after: titleLabel)
        stackView.setCustomSpacing(60, after: nameTextField) // Отступ перед кнопкой регистрации

        NSLayoutConstraint.activate([
            // Привязки ScrollView к краям экрана
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            // ContentView (внутренний контейнер)
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

            // StackView с полями
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 40),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
    }

    // MARK: - Keyboard Handling
    private func setupKeyboardHiding() {
        // Тап по экрану убирает клавиатуру
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)

        // Подписки на уведомления
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }

    @objc private func keyboardWillShow(notification: NSNotification) {
        guard let userInfo = notification.userInfo,
              let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        
        // Делаем отступ снизу, чтобы приподнять кнопки над клавиатурой
        let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardFrame.height - view.safeAreaInsets.bottom + 20, right: 0)
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }

    @objc private func keyboardWillHide() {
        scrollView.contentInset = .zero
        scrollView.scrollIndicatorInsets = .zero
    }

    // MARK: - Actions
    lazy var registerAction: UIAction = UIAction { [weak self] _ in
        guard let self = self else { return }
        self.viewBuilder.animateButton(self.registerButton)
        
        let user = UserData(
            email: self.emailTextField.text ?? "",
            password: self.passwordTextField.text ?? "",
            name: self.nameTextField.text ?? ""
        )
        
        service.createNewUser(user: user) { result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self.postRoute(to: WindowCase.login)
                case .failure(let error):
                    print("Registration error: \(error)")
                }
            }
        }
    }

    lazy var toLoginAction: UIAction = UIAction { [weak self] _ in
        self?.postRoute(to: WindowCase.login)
    }

    private func postRoute(to destination: WindowCase) {
        NotificationCenter.default.post(
            name: Notification.Name("routeVC"),
            object: nil,
            userInfo: ["vc": destination]
        )
    }
}
