import Quickshell.Io

JsonObject {
    property bool enabled: true
    property bool showOnHover: true
    property int mediaUpdateInterval: 500
    property int resourceUpdateInterval: 1000
    property int dragThreshold: 50
    property bool showDashboard: true
    property bool showMedia: true
    property bool showPerformance: true
    property bool showWeather: true
    property Sizes sizes: Sizes {}
    property Performance performance: Performance {}

    component Performance: JsonObject {
        property bool showBattery: true
        property bool showGpu: true
        property bool showCpu: true
        property bool showMemory: true
        property bool showStorage: true
        property bool showNetwork: true
    }

    component Sizes: JsonObject {
        readonly property int tabIndicatorHeight: 2
        readonly property int tabIndicatorSpacing: 3
        readonly property int infoWidth: 120
        readonly property int infoIconSize: 16
        readonly property int dateTimeWidth: 70
        readonly property int mediaWidth: 120
        readonly property int mediaProgressSweep: 120
        readonly property int mediaProgressThickness: 5
        readonly property int resourceProgessThickness: 6
        readonly property int weatherWidth: 150
        readonly property int mediaCoverArtSize: 90
        readonly property int mediaVisualiserSize: 50
        readonly property int resourceSize: 120
    }
}
