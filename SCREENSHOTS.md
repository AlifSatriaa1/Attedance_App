# 📸 Screenshots & UI Showcase

Visual guide to the Smart Attendance System interface and features.

## 🎨 App Flow

### 1. Splash Screen
**Duration**: 3 seconds  
**Features**:
- Animated app logo with scale effect
- Gradient purple background
- Loading indicator
- Smooth fade transition

**Design Elements**:
- App icon in white rounded container
- "Attendance" title in bold white text
- "Smart Presence System" subtitle
- Circular progress indicator

---

### 2. Home Screen

#### Header Section
**Features**:
- Gradient purple background (#1A008F to #3D1FA8)
- Real-time date display
- Real-time clock (HH:mm format)
- Notification icon button

**Layout**:
```
┌─────────────────────────────┐
│  Attendance System      🔔  │
│  Tuesday, 18 November 2025  │
│  14:30                      │
└─────────────────────────────┘
```

#### Statistics Card
**Features**:
- Gradient background (Purple to Pink)
- Three statistics columns
- Real-time data from Firebase
- Icon indicators

**Metrics**:
- Total Attendance (👥 icon)
- On Time Count (✓ icon)
- Late Count (⏰ icon)

**Layout**:
```
┌─────────────────────────────┐
│  Attendance Statistics      │
│                             │
│   👥        ✓        ⏰     │
│   25        20        5     │
│  Total   On Time    Late    │
└─────────────────────────────┘
```

#### Quick Actions Grid
**Features**:
- 2x2 grid layout
- Card-based design
- Icon + text labels
- Color-coded actions

**Actions**:
1. **Check In** (Green, 🔓 icon)
2. **Absent** (Orange, 📅 icon)
3. **History** (Blue, 📜 icon)
4. **Reports** (Purple, 📊 icon)

**Layout**:
```
┌──────────────┬──────────────┐
│   🔓         │   📅         │
│  Check In    │   Absent     │
│  Record...   │  Report...   │
├──────────────┼──────────────┤
│   📜         │   📊         │
│  History     │  Reports     │
│  View...     │  Analytics   │
└──────────────┴──────────────┘
```

#### Recent Activity
**Features**:
- Last 3 attendance records
- Status badges with colors
- Timestamp display
- "View All" button

**Layout**:
```
Recent Activity          View All →

┌─────────────────────────────┐
│ ✓  John Doe                 │
│    18 Nov 2025 | 08:15  [On Time]
└─────────────────────────────┘
┌─────────────────────────────┐
│ ⏰  Jane Smith               │
│    18 Nov 2025 | 09:30  [Late]
└─────────────────────────────┘
```

---

### 3. Camera Screen

#### Layout
**Features**:
- Full-screen camera preview
- Dark background
- Face detection overlay (Lottie animation)
- Bottom control panel

**Top Section**:
```
┌─────────────────────────────┐
│ ← Take a Selfie             │
│                             │
│    [Camera Preview]         │
│                             │
│    [Face Detection Ring]    │
│                             │
└─────────────────────────────┘
```

#### Bottom Panel
**Features**:
- White rounded container
- Drag handle indicator
- Instruction text with icon
- Large circular capture button

**Layout**:
```
┌─────────────────────────────┐
│         ━━━━                │
│                             │
│  💡  Position your face in  │
│      the frame and ensure   │
│      good lighting          │
│                             │
│           ⭕                │
│      Tap to capture         │
└─────────────────────────────┘
```

**Capture Button**:
- 72x72 dp size
- Gradient purple background
- White inner circle
- Camera icon
- Shadow effect

---

### 4. Attendance Screen

#### Status Card
**Features**:
- Full-width gradient card
- Status-based color (Green/Orange/Red)
- Large status icon
- Status text
- Date and time

**On Time Status**:
```
┌─────────────────────────────┐
│           ✓                 │
│         Attend              │
│  18 November 2025 | 08:15   │
└─────────────────────────────┘
```

**Late Status**:
```
┌─────────────────────────────┐
│           ⏰                │
│          Late               │
│  18 November 2025 | 09:30   │
└─────────────────────────────┘
```

#### Photo Section
**Features**:
- Card container
- Dotted border when empty
- Image preview when captured
- Tap to retake

**Empty State**:
```
┌─────────────────────────────┐
│  Your Photo                 │
│                             │
│  ┌ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ┐  │
│  │                       │  │
│  │         📷            │  │
│  │   Tap to take photo   │  │
│  │                       │  │
│  └ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ┘  │
└─────────────────────────────┘
```

#### Name Input
**Features**:
- Card container
- Prefix icon (person)
- Placeholder text
- Light gray background

**Layout**:
```
┌─────────────────────────────┐
│  Your Name                  │
│                             │
│  ┌─────────────────────────┐│
│  │ 👤  Enter your full name││
│  └─────────────────────────┘│
└─────────────────────────────┘
```

#### Location Display
**Features**:
- Card container
- Location icon
- Address text
- Loading state

**Layout**:
```
┌─────────────────────────────┐
│  Your Location              │
│                             │
│  ┌─────────────────────────┐│
│  │ 📍  Current Location    ││
│  │     123 Main Street,    ││
│  │     City, Postal Code,  ││
│  │     Country             ││
│  └─────────────────────────┘│
└─────────────────────────────┘
```

#### Submit Button
**Features**:
- Full-width button
- Gradient purple background
- Icon + text
- Shadow effect

**Layout**:
```
┌─────────────────────────────┐
│  ✓  Submit Attendance       │
└─────────────────────────────┘
```

---

### 5. Success Dialog

**Features**:
- Centered modal dialog
- Animated success icon
- Title and message
- Continue button

**Layout**:
```
┌─────────────────────────────┐
│                             │
│           ✓                 │
│        (animated)           │
│                             │
│        Success!             │
│                             │
│  Your attendance has been   │
│  recorded successfully      │
│                             │
│  ┌───────────────────────┐ │
│  │      Continue         │ │
│  └───────────────────────┘ │
│                             │
└─────────────────────────────┘
```

---

### 6. Profile Screen

#### Header
**Features**:
- Gradient background
- Large circular avatar
- Name and location

**Layout**:
```
┌─────────────────────────────┐
│                             │
│           👤                │
│     (large avatar)          │
│                             │
│   IDN Boarding School       │
│   Solo, Indonesia           │
│                             │
└─────────────────────────────┘
```

#### Options List
**Features**:
- Card-based list items
- Icon + text + arrow
- Tap interaction

**Layout**:
```
┌─────────────────────────────┐
│ ⚙️  Settings              → │
└─────────────────────────────┘
┌─────────────────────────────┐
│ 🔔  Notifications         → │
└─────────────────────────────┘
┌─────────────────────────────┐
│ ❓  Help & Support        → │
└─────────────────────────────┘
┌─────────────────────────────┐
│ ℹ️  About                 → │
└─────────────────────────────┘
```

---

## 🎨 Design System

### Color Palette
```
Primary Colors:
- Deep Purple:   #1A008F
- Medium Purple: #3D1FA8
- Light Purple:  #667EEA

Status Colors:
- Success/On Time: #4CAF50 (Green)
- Warning/Late:    #FF9800 (Orange)
- Error/Leave:     #F44336 (Red)
- Info:            #2196F3 (Blue)

Neutral Colors:
- Background:      #F5F7FA
- Card:            #FFFFFF
- Text Primary:    #000000
- Text Secondary:  #757575
- Border:          #E0E0E0
```

### Typography
```
Headings:
- H1: 28px, Bold
- H2: 24px, Bold
- H3: 20px, Bold
- H4: 18px, Bold

Body:
- Large:  16px, Regular
- Medium: 14px, Regular
- Small:  12px, Regular

Font Family: Roboto
```

### Spacing
```
- XS:  4px
- S:   8px
- M:   16px
- L:   24px
- XL:  32px
- XXL: 48px
```

### Border Radius
```
- Small:  8px
- Medium: 12px
- Large:  16px
- XLarge: 24px
- Circle: 50%
```

### Shadows
```
Card Shadow:
- Elevation: 2-4
- Color: rgba(0,0,0,0.1)
- Blur: 10-20px
- Offset: (0, 2-8)

Button Shadow:
- Elevation: 4-8
- Color: Primary with 0.4 opacity
- Blur: 12-20px
- Offset: (0, 6-10)
```

---

## 📱 Responsive Design

### Breakpoints
- Small:  < 600px (Mobile)
- Medium: 600-900px (Tablet)
- Large:  > 900px (Desktop)

### Adaptations
- Grid columns adjust based on screen width
- Font sizes scale proportionally
- Spacing adjusts for larger screens
- Images maintain aspect ratio

---

## ✨ Animations

### Splash Screen
- Duration: 1500ms
- Fade: 0 → 1 (0-500ms)
- Scale: 0.5 → 1 (0-700ms, elastic)

### Success Dialog
- Duration: 600ms
- Scale: 0 → 1 (elastic curve)
- Icon appears with bounce

### Button Press
- Duration: 100ms
- Scale: 1 → 0.95 → 1

### Page Transitions
- Duration: 500ms
- Fade transition between screens

---

## 🎯 Accessibility

### Touch Targets
- Minimum size: 48x48 dp
- Buttons: 56 dp height
- Icons: 24-32 dp

### Contrast Ratios
- Text on background: 4.5:1 minimum
- Large text: 3:1 minimum
- Interactive elements: Clear visual feedback

### Labels
- All icons have text labels
- Form fields have clear labels
- Buttons have descriptive text

---

**Note**: Actual screenshots should be added to a `/screenshots` folder in the repository for portfolio presentation.

Recommended screenshot sizes:
- Mobile: 1080x1920 (9:16)
- Tablet: 1536x2048 (3:4)
- Desktop: 1920x1080 (16:9)
