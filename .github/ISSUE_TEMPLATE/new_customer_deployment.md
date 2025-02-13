---
name: "New Deployment"
about: "Create a new customer/site/study deployment"
title: "[Title]"
labels: ["deployment", "customer"]
assignees: ""

---

### Description and special instructions:

### Details
- **Environment**: (e.g., Production, Staging):
- **Target Completion Time**: (e.g., Sep 6th)
- **Customer Business Name**:
- **Twilio Account SID**:
- **Prompt file name**:
- **Widget Host Page/Pages**:
- **Survey Enabled**: Yes
- **Deployment Type**:
  - Single page per site
  - Separate pages for site
  - Separate pages for studies
- **Clinic Notification Recipient Email(s)**:

### Initial Form Fields

- **First Name**
- **Phone**
- **Zip**
- **Therapeutic Areas**: (a dropdown with available study areas)

### Sites

- **Site**:
  - **Site Name**:
  - **Location URL**:
  - **Appointment Schedule**:
    - Days: (e.g., Mon-Fri)
    - Time: (e.g., 9:30am-5pm)
    - Restrictions: (e.g., last appointment time, block hours, etc.)
  - **Contact Phone**:
  - **Contact Email**:

### Studies

- **Study 1**:
  - **Study Name**:
  - **ICF File Names**:

### External Integration

- **Integration Enabled**: Yes/No
- **Type of Integration**: (e.g., CRIO, Clinspark, Realtime)

### **Confirmation Email**:

Dear {first_name},

This email is to confirm your onsite {appointment_goal} for {appointment_datetime}.

The address of our facility is {site_address}. Your interest in our studies is highly appreciated.

Best regards,
{customer_name_long}

### Schedules

- **Pre-configured or from Integration**:
- **Interval between slots**:
- **Maximum Patients per Slot**:
