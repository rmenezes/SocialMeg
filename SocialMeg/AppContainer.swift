import UIKit

final class AppContainer {
    let appInfo: () -> AppInfo
    let dataProvider: () -> NetworkDataProvider
    let userRepository: () -> UserRepositoring
    
    private init(
        appInfo: @escaping () -> AppInfo,
        dataProvider: @escaping () -> NetworkDataProvider,
        userRepository: @escaping () -> UserRepositoring
    ) {
        self.appInfo = appInfo
        self.dataProvider = dataProvider
        self.userRepository = userRepository
    }
}

extension AppContainer {
    static func live() -> AppContainer{
        let resourceLoader = AppInfoResourceLoader()
        let appInfo = { AppInfo(resourceLoader: resourceLoader) }
        let dataProvider = { NetworkDataProvider(appInfo: appInfo()) }
        return AppContainer(
            appInfo: appInfo,
            dataProvider: dataProvider,
            userRepository: {
                UserRepository(
                    service: UserService(
                        dataProvider: dataProvider()
                    )
                )
            }
        )
    }
}
