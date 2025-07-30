# 📦 Scanxiety™: The Emotional Barcode Scanner

**What if barcodes didn't just tell you what something costs, but what it *means*?**

---

## 🎭 Project Overview

Scanxiety is a subversive iOS app that transforms mundane object recognition into emotional archaeology. Instead of scanning barcodes for prices, users point their camera at any object to receive a "Scanxiety™ Emotional Receipt" — a poetically absurd breakdown of the item's hidden psychological toll.

From "regret residue: dangerously high" on a bag of chips to "void-filling capacity: moderate" on a coffee mug, Scanxiety exposes the emotional baggage we carry with every purchase, every possession, every attempt to buy our way to happiness.

## 🧠 The Concept

We encounter data everywhere — barcodes, price tags, product codes — but this data is cold, transactional, sterile. Scanxiety hacks this utilitarian logic and turns it inside out, replacing monetary cost with emotional cost, revealing the invisible weight of our consumer choices.

**This project critiques:**
- The commodification of emotion in late-stage capitalism
- Surveillance capitalism's quantification of human experience  
- The therapeutic culture's obsession with measuring feelings
- The gap between what objects promise and what they deliver
- Our collective delusion that retail therapy actually works

## 🔧 How We Hacked It

### The Data
- **Input**: Real-world objects captured via iPhone camera
- **Processing**: OpenAI GPT-4o Vision API analyzes images 
- **Output**: Poetic emotional metadata disguised as thermal receipts

### Technical Implementation
- **Platform**: Native iOS app built with SwiftUI
- **Computer Vision**: AVFoundation for camera capture
- **AI Integration**: OpenAI Vision API for object recognition and emotional analysis
- **Output**: Thermal receipt-style formatting with ASCII art borders
- **Sharing**: Native iOS share sheet for saving/sharing receipts

### The Hack
```swift
// Instead of: "Banana - $0.99"
// We generate: "Guilt score: 34/100; Potassium anxiety: detected"

let emotionalPrompt = """
You are the Scanxiety™ AI. Analyze this object's hidden emotional cost.
Generate poetic assessments like:
- "Contains 45% impulsive sadness"  
- "Void-filling capacity: moderate"
- "Self-worth correlation: inverse"
"""
```

## 📱 Features

- **Object Recognition**: Point camera at literally anything
- **Emotional Analysis**: AI-generated psychological assessments  
- **Thermal Receipt Aesthetic**: Authentic receipt formatting
- **Varied Emotional Formats**: Percentages, scores, detections, correlations
- **Share & Save**: Download receipts as images or text
- **Deliberately Useless**: Provides no practical value whatsoever

## 🎪 Sample Receipts

```
╔══════════════════════════════════╗
║        SCANXIETY™ SCANNER        ║
║    Emotional Checkout System     ║
╚══════════════════════════════════╝

ITEM SCANNED: iPhone 15 Pro Max
MONETARY COST: CAD $1,499.00

EMOTIONAL ANALYSIS:
Tech dependency: dangerously high
Status anxiety: elevated  
FOMO levels: critical
Planned obsolescence grief: processing
Innovation theater: detected

* Feelings are non-refundable
* For emotional support, please
  reconsider your life choices

Thank you for your feelings.
SCANXIETY™ - Exposing the true cost
```

## 🎨 The Art Project

Scanxiety exists in the liminal space between functional app and performance art. It's:

- **Deliberately Useless** → But emotionally revealing
- **Technologically Sophisticated** → But conceptually absurd  
- **Commercially Styled** → But anti-commercial in purpose
- **Data-Driven** → But poetry-generating
- **Consumer-Facing** → But consumer-questioning

## 🔍 What Does It Expose?

### About Our Data
- **Ignored Dataset**: The emotional metadata of everyday objects
- **Hidden Patterns**: How we attach feelings to inanimate things
- **Surveillance Parallel**: If apps can track our purchases, why not our feelings?

### About Our Culture
- **Retail Therapy Myth**: Objects promise emotional solutions they can't deliver
- **Quantified Self**: Our obsession with measuring everything, including feelings
- **Consumer Guilt**: The psychological tax of owning too much stuff
- **Emotional Labor**: Even our feelings become transactional

## 🛠 Technical Setup

### Requirements
- iOS 17.0+
- Xcode 15.0+
- OpenAI API Key
- Camera permissions

### Installation
```bash
git clone https://github.com/your-username/scanxiety
cd scanxiety
# Copy the template and add your API key
cp BarcodeScanner/Info.plist.example BarcodeScanner/Info.plist
# Edit Info.plist with your actual OpenAI API key
# Build and run in Xcode
```

### Configuration
1. **Get an OpenAI API Key**: Sign up at [OpenAI](https://openai.com/api/) and create an API key
2. **Set up your local Info.plist**:
   ```bash
   cp BarcodeScanner/Info.plist.example BarcodeScanner/Info.plist
   ```
3. **Add your API key** to `BarcodeScanner/Info.plist`:
   ```xml
   <key>OpenAI_API_Key</key>
   <string>your-actual-api-key-here</string>
   ```

⚠️ **Security Note**: Your `Info.plist` file is gitignored to protect your API key from being committed.

## 💭 Critical Statement

*"Sometimes a purchase says more than just $2.99 — it says, 'You're trying to fill a void.'"*

Scanxiety transforms the cold logic of consumer data into warm, absurd poetry. It's a mirror held up to our retail culture, asking: What are we really buying? And what emotional debt are we accumulating in the process?

In a world where everything is quantified, commodified, and surveilled, Scanxiety offers the deliberately useless service of quantifying the unquantifiable — our feelings about stuff. It's therapy disguised as technology, criticism disguised as convenience, art disguised as an app.

---

**Next time you go to purchase something, ask yourself: "What would Scanxiety print out for me instead?"**

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

*Scanxiety™ - Because every transaction has an emotional cost.* 
