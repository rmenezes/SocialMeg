import Foundation

protocol AppInfoResourceLoading {
    func loadInfo() -> [String: Any]
}

struct AppInfoResourceLoader: AppInfoResourceLoading {
    func loadInfo() -> [String: Any] {
        guard
            let path = Bundle.main.url(
                forResource: "Info",
                withExtension: "plist"
            ),
            let data = try? Data(contentsOf: path),
            let properties = try? PropertyListSerialization.propertyList(
                from: data,
                format: nil
            ) as? [String: Any]
        else { return [:] }
        
        return properties
    }
}
