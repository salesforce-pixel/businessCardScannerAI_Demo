# AI-powered Business Card Analyzer in Salesforce

**Author:** Rajeev Shekhar – rshekhar@salesforce.com

This is a Salesforce DX project that deploys an AI-powered **Business Card Analyzer in Salesforce**, designed to analyze uploaded Business Cards in image format using multimodal capabilities in Prompt Templates.

## Prerequisites

Make sure you have the following tools installed and the required features enabled before starting:

### Required Tools

* **Salesforce CLI** (sf CLI) – Latest version
* **Node.js** – Version 18 or higher
* **Git** – For version control

### Org Feature Enablement

Enable the following features in your target Salesforce org:

* Einstein Generative AI
* Agentforce
* Prompt Builder
* Data Cloud

## Quick Start Guide

### Step 1: Clone the Repository

```bash
git clone https://github.com/salesforce-pixel/businessCardScannerAI_Demo.git
cd businessCardScannerAI_Demo
```

### Step 2: Authenticate with Your Salesforce Org

```bash
sf org login web -a targetOrg
```

**Note:** Replace `targetOrg` with your preferred alias for the target org.

### Step 3: Deploy to Salesforce

```bash
sf project deploy start -x manifest/package.xml -o targetOrg -l NoTestRun
```

This command deploys the metadata into your target org.

### Step 4: Configure the Lightning App Builder

* After deployment and LWC creation, create a App Page in Lightning App Builder, and make this Page available in the the App of your choice.