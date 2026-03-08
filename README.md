# Certificate Generation System 🎓

A comprehensive PDF certificate generation system with QR code verification, built with Python and Flask.

## Features ✨

- **Professional PDF Certificates**: Generate beautiful, professional certificates in PDF format
- **QR Code Integration**: Each certificate includes a unique QR code for instant verification
- **Web Interface**: User-friendly web interface for certificate generation and management
- **Bulk Generation**: Generate multiple certificates at once using CSV data
- **Secure Verification**: Cryptographic hash verification and tamper-proof certificates
- **Database Storage**: SQLite database for storing certificate records
- **Command Line Interface**: CLI for automated certificate generation
- **Responsive Design**: Mobile-friendly web interface

## Quick Start 🚀

### 1. Install Dependencies

```bash
pip install -r requirements.txt
```

### 2. Run the Web Application

```bash
python enhanced_web.py
```

Visit `http://localhost:5000` to access the web interface.

### 3. Generate Your First Certificate

- Click "Generate Certificate" on the home page
- Fill in the recipient details
- Click "Generate Certificate"
- Download the PDF and share it!

## System Components 📋

### Core Files

- `certificate_generator.py` - Main certificate generation engine
- `Generate QR Code.py` - QR code generation utilities
- `enhanced_web.py` - Flask web application
- `cli.py` - Command line interface
- `requirements.txt` - Python dependencies

### Templates (Web Interface)

- `templates/base.html` - Base template with navigation
- `templates/index.html` - Home page
- `templates/generate.html` - Certificate generation form
- `templates/bulk_generate.html` - Bulk generation interface
- `templates/certificates_list.html` - List all certificates
- `templates/verification_result.html` - Certificate verification page

## Usage Examples 💡

### Web Interface

1. **Generate Single Certificate**:
   - Navigate to `/generate`
   - Fill in recipient name, course name, completion date
   - Optionally add instructor, organization, and grade
   - Click "Generate Certificate"

2. **Bulk Generation**:
   - Navigate to `/bulk_generate`
   - Enter CSV data with format: `Name, Course, Date, Instructor, Organization, Grade`
   - Click "Generate All Certificates"

3. **Verify Certificate**:
   - Navigate to `/verify/<certificate_id>`
   - Or use the verification form on the home page

### Command Line Interface

```bash
# Generate a single certificate
python cli.py generate --name "John Doe" --course "Python Programming" --date "2025-10-01"

# Verify a certificate
python cli.py verify CERT_12345ABC

# List all certificates
python cli.py list --limit 20

# Bulk generate from CSV
python cli.py bulk certificates.csv
```

### Python API

```python
from certificate_generator import CertificateGenerator

# Initialize generator
cert_gen = CertificateGenerator()

# Generate certificate
cert_data = {
    "recipient_name": "Alice Johnson",
    "course_name": "Data Science Fundamentals",
    "completion_date": "2025-10-01",
    "instructor_name": "Dr. Smith",
    "organization": "Tech Academy",
    "grade": "A+"
}

pdf_path = cert_gen.create_certificate_pdf(cert_data)
print(f"Certificate generated: {pdf_path}")
```

## File Structure 📁

```
Certificate Generation/
├── .gitignore                   # Ignore generated files and local artifacts
├── certificate_generator.py      # Main certificate engine
├── Generate QR Code.py           # QR code utilities
├── enhanced_web.py               # Web application
├── cli.py                        # Command line interface
├── requirements.txt              # Dependencies
├── docs/                         # Deployment and usage documentation
├── scripts/                      # Deployment/setup helper scripts
├── certificates.db               # SQLite database (auto-created)
├── templates/                    # Web templates
│   ├── base.html
│   ├── index.html
│   ├── generate.html
│   ├── bulk_generate.html
│   ├── certificates_list.html
│   └── verification_result.html
├── certificates/                 # Generated PDF certificates (.gitkeep tracked)
├── qr_codes/                     # Generated QR code images (.gitkeep tracked)
└── README.md
```

## Certificate Features 📜

Each generated certificate includes:

- **Professional Design**: Clean, professional layout with decorative borders
- **Unique Certificate ID**: Format: `CERT_XXXXXXXX`
- **QR Code**: Contains verification data and URL
- **Security Hash**: Cryptographic hash for tamper detection
- **Complete Information**: Recipient, course, dates, instructor, organization, grade
- **High Quality PDF**: Suitable for printing and digital distribution

## API Endpoints 🔌

### Web API

- `GET /` - Home page
- `GET /generate` - Certificate generation form
- `POST /generate` - Generate certificate
- `GET /bulk_generate` - Bulk generation form
- `POST /bulk_generate` - Bulk generate certificates
- `GET /certificates` - List all certificates
- `GET /verify/<certificate_id>` - Verify certificate
- `POST /api/verify` - API verification endpoint

### Verification API Example

```bash
curl -X POST http://localhost:5000/api/verify \
  -H "Content-Type: application/json" \
  -d '{"certificate_id": "CERT_12345ABC"}'
```

## CSV Format for Bulk Generation 📊

```csv
John Doe, Python Programming, 2025-10-01, Dr. Smith, Tech Academy, A+
Jane Smith, Data Science, 2025-10-02, Prof. Johnson, Data Institute, B+
Mike Wilson, Web Development, 2025-10-03, , Online Academy, Pass
```

**Format**: `Name, Course, Date, Instructor, Organization, Grade`
- First 3 fields are required
- Date format: YYYY-MM-DD
- Empty fields can be left blank (but include the comma)

## Database Schema 🗄️

```sql
CREATE TABLE certificates (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    certificate_id TEXT UNIQUE,
    recipient_name TEXT,
    course_name TEXT,
    completion_date TEXT,
    issue_date TEXT,
    instructor_name TEXT,
    organization TEXT,
    grade TEXT,
    certificate_hash TEXT,
    qr_code_data TEXT,
    file_path TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

## Customization 🎨

### Certificate Design

Modify the `draw_certificate_design()` method in `certificate_generator.py` to customize:
- Colors and fonts
- Layout and positioning
- Logo and branding
- Border styles
- Text formatting

### QR Code Content

Customize QR code data in the `generate_qr_code()` method:
- Add custom verification URLs
- Include additional metadata
- Modify error correction level
- Change size and styling

## Security Features 🔒

- **Cryptographic Hashes**: Each certificate has a SHA-256 hash for integrity
- **Unique IDs**: MD5-based unique certificate identifiers
- **Database Storage**: Secure SQLite database storage
- **QR Code Verification**: QR codes contain verification data
- **Tamper Detection**: Hash verification prevents tampering

## Deployment 🌐

### Local Development

```bash
python enhanced_web.py
# Access at http://localhost:5000
```

### Production Deployment

```bash
# Install gunicorn
pip install gunicorn

# Run with gunicorn
gunicorn -w 4 -b 0.0.0.0:5000 enhanced_web:app
```

### Docker Deployment

```dockerfile
FROM python:3.9-slim

WORKDIR /app
COPY requirements.txt .
RUN pip install -r requirements.txt

COPY . .
EXPOSE 5000

CMD ["gunicorn", "-w", "4", "-b", "0.0.0.0:5000", "enhanced_web:app"]
```

## Troubleshooting 🔧

### Common Issues

1. **Import Errors**: Make sure all dependencies are installed with `pip install -r requirements.txt`

2. **Database Errors**: The SQLite database is created automatically. Check file permissions.

3. **PDF Generation Issues**: Ensure ReportLab is properly installed and fonts are available.

4. **QR Code Problems**: Verify PIL/Pillow is installed correctly.

### Error Messages

- **"Certificate not found"**: Certificate ID doesn't exist in database
- **"Invalid date format"**: Use YYYY-MM-DD format for dates
- **"File permission denied"**: Check write permissions for certificates/ and qr_codes/ directories

## Contributing 🤝

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests if applicable
5. Submit a pull request

## License 📄

This project is open source and available under the MIT License.

## Support 💬

For questions, issues, or suggestions:
- Create an issue on GitHub
- Check the troubleshooting section
- Review the example code

---

## Sending Certificates (Email / WhatsApp)

You can send generated certificates in bulk from the bulk generation result page. The system supports two delivery methods:

- Email (attachments sent via SMTP)
- WhatsApp (via Twilio - requires a Twilio account and public media URLs)

### Configure SMTP (recommended)

Set the following environment variables or provide them in the bulk send request payload:

- `SMTP_SERVER` (e.g. smtp.gmail.com)
- `SMTP_PORT` (usually 587 for TLS)
- `SMTP_USER` (SMTP username / email)
- `SMTP_PASS` (SMTP password or app password)

Example (PowerShell):

```powershell
$env:SMTP_SERVER = 'smtp.gmail.com'; $env:SMTP_PORT = '587'; $env:SMTP_USER = 'you@example.com'; $env:SMTP_PASS = 'app-password'
```

Once configured, generate certificates in bulk. On the Bulk Result page select recipients and choose "Email" and click "Send Selected".

### Configure Twilio (WhatsApp)

To send WhatsApp messages via Twilio you need:

- A Twilio account and WhatsApp-enabled phone
- `TWILIO_SID`, `TWILIO_TOKEN`, `TWILIO_FROM` environment variables (TWILIO_FROM is the Twilio WhatsApp number without the `whatsapp:` prefix)

Note: Twilio requires media (attachment) URLs to be publicly reachable. Local file attachments are not supported by Twilio unless you upload them to a public storage (S3, static server) and pass the URL.

### UI Notes

- The Bulk Result page will list generated certificates. When certificates were created in "full" mode the page includes recipient emails/phones (if provided in CSV) and will attach PDFs when sending by email.
- For WhatsApp you'll need to provide publicly accessible file URLs in the `files` objects or use a different mechanism to share attachments.

If you want help wiring an SMTP provider (Gmail/SendGrid) or uploading files to a public bucket for Twilio, tell me which provider you'd like and I can add automated helpers.


**Built with ❤️ using Python, Flask, ReportLab, and QRCode libraries.**