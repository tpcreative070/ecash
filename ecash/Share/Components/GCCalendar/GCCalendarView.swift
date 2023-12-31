//
//  GCCalendarView.swift
//  GCCalendar
//
//  Created by Gray Campbell on 1/28/16.
//

import UIKit

// MARK: Enumerables

/// The display mode when displaying a calendar.

public enum GCCalendarDisplayMode {
    /// The calendar is displayed one month at a time.
    case month
}

struct GCCalendarViewKey {
    public static let departure = "departure"
    public static let mReturn = "return"
}

// MARK: - Properties & Initializers

/// The GCCalendarView class defines a view containing an interactive calendar.

public final class GCCalendarView: UIView {
    
    // MARK: Properties
    fileprivate var configuration: GCCalendarConfiguration!
    fileprivate var selectedDate = Date()
    fileprivate var selectedDayView: GCCalendarDayView? = nil
    fileprivate var userSelectedDate: Date?
    fileprivate var headerView = UIStackView()
    fileprivate var monthViews: [GCCalendarMonthView] = []
    fileprivate var panGestureStartLocation: CGFloat!
    fileprivate var dicFlight = Dictionary<String,Date>()
    fileprivate var isProperlyConfigured: Bool {
        return (self.configuration != nil && self.displayMode != nil)
    }
    
    static public var isAuto  = false
    
    /// The object that acts as the delegate of the calendar view.
    public var delegate: GCCalendarViewDelegate! {
        didSet {
            self.updateConfiguration()
            if self.displayMode != nil {
                self.refresh()
            }
        }
    }
    
    /// The display mode for the calendar view.
    public var displayMode: GCCalendarDisplayMode! {
        didSet {
            if self.configuration != nil && self.displayMode != oldValue {
                self.refresh()
            }
        }
    }
    
    //Checking departure or return
    public var isReturn : Bool = true
    
    // MARK: Initializers
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.clipsToBounds = true
    }
    
    /// Initializes and returns a newly allocated calendar view object with the specified frame rectangle.
    ///
    /// - Parameter frame: The frame rectangle for the calendar view, measured in points. The origin of the frame is relative to the superview in which you plan to add it. This method uses the frame rectangle to set the center and bounds properties accordingly.
    /// - Returns: An initialized calendar view object.
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.clipsToBounds = true
    }
    
    /// Initializes and returns a newly allocated calendar view object.
    ///
    /// Use this initializer if you are planning on using layout constraints. If you are using frame rectangles to layout your views, use `init(frame:)` instead.
    ///
    /// - Returns: An initialized calendar view object.
    
    public convenience init() {
        self.init(frame: CGRect.zero)
    }
}

// MARK: - Layout

public extension GCCalendarView {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if self.isProperlyConfigured {
            self.resetLayout()
        }
    }
    
    fileprivate func resetLayout() {
        self.previousView.center.x = -self.bounds.size.width * 0.5
        self.currentView.center.x = self.bounds.size.width * 0.5
        self.nextView.center.x = self.bounds.size.width * 1.5
    }
}

// MARK: - Configuration

fileprivate extension GCCalendarView {
    
    func updateConfiguration() {
        print("updateConfiguration")
        self.configuration = GCCalendarConfiguration()
        self.configuration.calendar = self.delegate.calendar(calendarView: self)
        self.configuration.weekdayLabelFont = self.delegate.weekdayLabelFont(calendarView: self)
        self.configuration.weekdayLabelTextColor = self.delegate.weekdayLabelTextColor(calendarView: self)
        self.configuration.pastDatesEnabled = self.delegate.pastDatesEnabled(calendarView: self)
        self.configuration.pastDateFont = self.delegate.pastDateFont(calendarView: self)
        self.configuration.pastDateEnabledTextColor = self.delegate.pastDateEnabledTextColor(calendarView: self)
        self.configuration.pastDateDisabledTextColor = self.delegate.pastDateDisabledTextColor(calendarView: self)
        self.configuration.pastDateSelectedFont = self.delegate.pastDateSelectedFont(calendarView: self)
        self.configuration.pastDateSelectedTextColor = self.delegate.pastDateSelectedTextColor(calendarView: self)
        self.configuration.pastDateSelectedBackgroundColor = self.delegate.pastDateSelectedBackgroundColor(calendarView: self)
        self.configuration.currentDateFont = self.delegate.currentDateFont(calendarView: self)
        self.configuration.currentDateTextColor = self.delegate.currentDateTextColor(calendarView: self)
        self.configuration.currentDateSelectedFont = self.delegate.currentDateSelectedFont(calendarView: self)
        self.configuration.currentDateSelectedTextColor = self.delegate.currentDateSelectedTextColor(calendarView: self)
        self.configuration.currentDateSelectedBackgroundColor = self.delegate.currentDateSelectedBackgroundColor(calendarView: self)
        self.configuration.futureDateFont = self.delegate.futureDateFont(calendarView: self)
        self.configuration.futureDateTextColor = self.delegate.futureDateTextColor(calendarView: self)
        self.configuration.futureDateSelectedFont = self.delegate.futureDateSelectedFont(calendarView: self)
        self.configuration.futureDateSelectedTextColor = self.delegate.futureDateSelectedTextColor(calendarView: self)
        self.configuration.futureDateSelectedBackgroundColor = self.delegate.futureDateSelectedBackgroundColor(calendarView: self)
        self.configuration.selectedDate = { return self.selectedDate }
        self.delegate.createdCalendar(date: Date())
        self.configuration.createdCalendar = { date in
            self.delegate.createdCalendar(date: date)
        }
        self.configuration.dayViewSelected = { dayView in
            print("dayViewSelected")
            if self.selectedDayView != dayView{
                self.selectedDayView?.unhighlight()
            }
            self.selectedDate = dayView.date!
            self.selectedDayView = dayView
            self.userSelectedDate = dayView.date
            self.delegate.calendarView(self, didSelectDate: self.selectedDate, inCalendar: self.configuration.calendar)
            if self.readyToFlight(date: dayView.date ?? Date()){
                self.delegate.calendar(date: self.dicFlight)
            }
        }
    }
}

// MARK: - Refresh

fileprivate extension GCCalendarView {
    func refresh() {
        self.removeHeaderView()
        self.addHeaderView()
        self.removeMonthViews()
        switch self.displayMode! {
            case .month:
                self.addMonthViews()
        }
    }
}

// MARK: - Header View

fileprivate extension GCCalendarView {
    
    func addHeaderView() {
        self.headerView = UIStackView()
        self.headerView.axis = .horizontal
        self.headerView.distribution = .fillEqually
        let firstWeekdayIndex = self.configuration.calendar.firstWeekday - 1
        let weekdaySymbols = self.configuration.calendar.veryShortWeekdaySymbols
        let reorderedWeekdaySymbols = weekdaySymbols[firstWeekdayIndex..<weekdaySymbols.count] + weekdaySymbols[0..<firstWeekdayIndex]
        reorderedWeekdaySymbols.forEach { weekdaySymbol in
            let weekdayLabel = UILabel()
            weekdayLabel.text = weekdaySymbol
            weekdayLabel.textAlignment = .center
            weekdayLabel.font = self.configuration.weekdayLabelFont
            weekdayLabel.textColor = self.configuration.weekdayLabelTextColor
            self.headerView.addArrangedSubview(weekdayLabel)
        }
        self.headerView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.headerView)
        self.addHeaderViewConstraints()
    }
    
    func removeHeaderView() {
        self.headerView.removeFromSuperview()
    }
    
    // MARK: Constraints
    func addHeaderViewConstraints() {
        self.headerView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.headerView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        self.headerView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        self.headerView.heightAnchor.constraint(equalToConstant: 15).isActive = true
    }
}

// MARK: - Week & Month Views
internal extension GCCalendarView {
    fileprivate var previousViewDisabled: Bool {
        if !self.configuration.pastDatesEnabled {
            if self.previousView.isKind(of: GCCalendarMonthView.self) {
                return self.currentMonthView.contains(date: Date())
            }
        }
        return false
    }
    
    // MARK: Views
    fileprivate var previousView: UIView {
        switch self.displayMode! {
            case .month:
                return self.previousMonthView
        }
    }
    
    fileprivate var currentView: UIView {
        switch self.displayMode! {
            case .month:
                return self.currentMonthView
        }
    }
    
    fileprivate var nextView: UIView {
        switch self.displayMode! {
            case .month:
                return self.nextMonthView
        }
    }
    
    // MARK: Toggle Views
    @objc func toggleCurrentView(_ pan: UIPanGestureRecognizer) {
        switch pan.state {
            case .began:
                self.panGestureStartLocation = pan.location(in: self).x
            case .changed:
                let changeInX = pan.location(in: self).x - self.panGestureStartLocation
                if !(self.previousViewDisabled && self.currentView.center.x + changeInX > self.bounds.size.width * 0.5) {
                    self.previousView.center.x += changeInX
                    self.currentView.center.x += changeInX
                    self.nextView.center.x += changeInX
                }
                self.panGestureStartLocation = pan.location(in: self).x
            case .ended:
                if self.currentView.center.x < (self.bounds.size.width * 0.5) - 25 {
                    UIView.animate(withDuration: 0.25, animations: self.showNextView, completion: self.nextViewDidShow)
                }
                else if self.currentView.center.x > (self.bounds.size.width * 0.5) + 25 {
                    UIView.animate(withDuration: 0.25, animations: self.showPreviousView, completion: self.previousViewDidShow)
                }
                else {
                    UIView.animate(withDuration: 0.15, animations: { self.resetLayout() })
                }
            default:
                break
        }
    }
    
    fileprivate func showPreviousView() {
        self.previousView.center.x = self.bounds.size.width * 0.5
        self.currentView.center.x = self.bounds.size.width * 1.5
    }
    
    fileprivate func showNextView() {
        self.currentView.center.x = -self.bounds.size.width * 0.5
        self.nextView.center.x = self.bounds.size.width * 0.5
    }
    
    fileprivate func previousViewDidShow(_ finished: Bool) {
        print("previousViewDidShow")
        if finished {
            switch self.displayMode! {
            case .month:
                self.previousMonthViewDidShow(finished)
            }
        }
    }
    
    fileprivate func nextViewDidShow(_ finished: Bool) {
        print("nextViewDidShow")
        if finished {
            switch self.displayMode! {
                case .month:
                    self.nextMonthViewDidShow(finished)
            }
        }
    }
}

// MARK: - Today
fileprivate extension GCCalendarView {
    func findDateInMonthViews(date: Date) {
        print("findDateInMonthViews")
        if self.previousMonthView.contains(date: date) {
            UIView.animate(withDuration: 0.15, animations: self.showPreviousView, completion: self.previousMonthViewDidShow)
        }
        else if self.currentMonthView.contains(date: date) {
            self.currentMonthView.select(date: date)
            self.userSelectedDate = nil
        }
        else if self.nextMonthView.contains(date: date) {
            UIView.animate(withDuration: 0.15, animations: self.showNextView, completion: self.nextMonthViewDidShow)
        }
        else {
            if date < self.selectedDate {
                self.show(date: date, animations: self.showPreviousView, monthViewReuse: self.reuseNextMonthView) { finished in
                    if finished {
                        self.previousMonthViewDidShow(finished)
                        let newStartDate = self.nextMonthStartDate(currentMonthStartDate: self.currentMonthView.startDate)
                        self.nextMonthView.startDate = newStartDate
                    }
                }
            }
            else if date > self.selectedDate {
                self.show(date: date, animations: self.showNextView, monthViewReuse: self.reusePreviousMonthView) { finished in
                    if finished {
                        self.nextMonthViewDidShow(finished)
                        let newStartDate = self.previousMonthStartDate(currentMonthStartDate: self.currentMonthView.startDate)
                        self.previousMonthView.startDate = newStartDate
                    }
                }
            }
        }
    }
    
    func show(date: Date, animations: @escaping () -> Void, monthViewReuse: @escaping ((Date) -> Void), completion: @escaping ((Bool) -> Void)) {
        UIView.animate(withDuration: 0.08, animations: animations) { finished in
            if finished {
                let newStartDate = self.currentMonthStartDate(fromDate: date)
                monthViewReuse(newStartDate)
                self.resetLayout()
                UIView.animate(withDuration: 0.08, animations: animations) { finished in completion(finished) }
            }
        }
    }
}

// MARK: - Month Views
fileprivate extension GCCalendarView {
    
    func addMonthViews() {
        let currentMonthStartDate = self.currentMonthStartDate(fromDate: self.selectedDate)
        let previousMonthStartDate = self.previousMonthStartDate(currentMonthStartDate: currentMonthStartDate)
        let nextMonthStartDate = self.nextMonthStartDate(currentMonthStartDate: currentMonthStartDate)
        for startDate in [previousMonthStartDate, currentMonthStartDate, nextMonthStartDate] {
            let monthView = GCCalendarMonthView(configuration: self.configuration)
            monthView.startDate = startDate
            monthView.translatesAutoresizingMaskIntoConstraints = false
            monthView.addPanGestureRecognizer(target: self, action: #selector(self.toggleCurrentView(_:)))
            self.addSubview(monthView)
            self.monthViews.append(monthView)
            monthView.topAnchor.constraint(equalTo: self.headerView.bottomAnchor).isActive = true
            monthView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
            monthView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        }
        self.resetLayout()
    }
    
    func removeMonthViews() {
        self.monthViews.forEach { $0.removeFromSuperview() }
        self.monthViews.removeAll()
    }
    
    // MARK: Views
    var previousMonthView: GCCalendarMonthView {
        return self.monthViews[0]
    }
    
    var currentMonthView: GCCalendarMonthView {
        return self.monthViews[1]
    }
    
    var nextMonthView: GCCalendarMonthView {
        return self.monthViews[2]
    }
    
    // MARK: Start Dates
    func previousMonthStartDate(currentMonthStartDate: Date) -> Date {
        return self.configuration.calendar.date(byAdding: .month, value: -1, to: currentMonthStartDate)!
    }
    
    func currentMonthStartDate(fromDate date: Date) -> Date {
        var components = self.configuration.calendar.dateComponents([.day, .month, .year], from: date)
        components.day = 1
        return self.configuration.calendar.date(from: components)!
    }
    
    func nextMonthStartDate(currentMonthStartDate: Date) -> Date {
        return self.configuration.calendar.date(byAdding: .month, value: 1, to: currentMonthStartDate)!
    }
    
    // MARK: Show Month View
    func previousMonthViewDidShow(_ finished: Bool) {
        print("previousMonthViewDidShow")
        if finished {
            let newStartDate = self.previousMonthStartDate(currentMonthStartDate: self.previousMonthView.startDate)
            self.reuseNextMonthView(newStartDate: newStartDate)
            self.monthViewDidShow()
        }
    }
    
    func nextMonthViewDidShow(_ finished: Bool) {
        print("nextMonthViewDidShow")
        if finished {
            let newStartDate = self.nextMonthStartDate(currentMonthStartDate: self.nextMonthView.startDate)
            self.reusePreviousMonthView(newStartDate: newStartDate)
            self.monthViewDidShow()
        }
    }
    
    func reuseNextMonthView(newStartDate: Date) {
        print("reuseNextMonthView")
        self.nextMonthView.startDate = newStartDate
        self.monthViews.insert(self.nextMonthView, at: 0)
        self.monthViews.removeLast()
    }
    
    func reusePreviousMonthView(newStartDate: Date) {
        print("reusePreviousMonthView")
        self.previousMonthView.startDate = newStartDate
        self.monthViews.append(self.previousMonthView)
        self.monthViews.removeFirst()
    }
    
    func monthViewDidShow() {
        self.resetLayout()
        self.configuration.createdCalendar(currentMonthView.startDate)
        if let mSelected = compareDate(date: currentMonthView.startDate) {
            self.currentMonthView.select(date: mSelected)
        }
    }
}

// MARK: - Public Functions
public extension GCCalendarView {
    /// Tells the calendar view to select the current date, updating any visible week views or month views if necessary.
    func today() {
        self.select(date: Date())
    }
    /// Tells the calendar view to select the specified date, updating any visible week views or month views if necessary.
    func select(date: Date) {
        if self.isProperlyConfigured && !self.configuration.calendar.isDate(date, inSameDayAs: self.selectedDate) {
            self.userSelectedDate = date
            switch self.displayMode! {
                case .month:
                    self.findDateInMonthViews(date: date)
            }
        }
    }
    
    func compareDate(date : Date) -> Date?{
        if let mUserSelected = userSelectedDate{
            if TimeHelper.getString(time: mUserSelected, dateFormat: TimeHelper.FormatMonth) == TimeHelper.getString(time: date, dateFormat: TimeHelper.FormatMonth) {
                return mUserSelected
            }
        }
        return nil
    }
    
    func readyToFlight(date : Date) -> Bool{
        if isReturn{
            print("readyToFlight \(isReturn)")
            if let departureDate = dicFlight[GCCalendarViewKey.departure]{
                if departureDate > date {
                    dicFlight[GCCalendarViewKey.departure] = date
                    return false
                }else{
                    dicFlight[GCCalendarViewKey.mReturn] = date
                }
            }else{
                dicFlight[GCCalendarViewKey.departure] = date
                return false
            }
        }else{
            dicFlight[GCCalendarViewKey.departure] = date
        }
        return true
    }
}
