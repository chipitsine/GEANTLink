/*
    Copyright 2015-2016 Amebis
    Copyright 2016 GÉANT

    This file is part of GÉANTLink.

    GÉANTLink is free software: you can redistribute it and/or modify it
    under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    GÉANTLink is distributed in the hope that it will be useful, but
    WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with GÉANTLink. If not, see <http://www.gnu.org/licenses/>.
*/

#include <StdAfx.h>


//////////////////////////////////////////////////////////////////////
// wxEAPTLSConfigPanel
//////////////////////////////////////////////////////////////////////

wxEAPTLSConfigPanel::wxEAPTLSConfigPanel(eap::config_tls &cfg, wxWindow* parent) :
    m_cfg(cfg),
    wxEAPTLSConfigPanelBase(parent)
{
    // Load and set icon.
    if (m_certmgr.load(_T("certmgr.dll"), NULL, LOAD_LIBRARY_AS_DATAFILE | LOAD_LIBRARY_AS_IMAGE_RESOURCE)) {
        HICON icon;
        if (SUCCEEDED(LoadIconWithScaleDown(m_certmgr, MAKEINTRESOURCE(218), GetSystemMetrics(SM_CXICON), GetSystemMetrics(SM_CYICON), &icon))) {
            m_icon.CreateFromHICON(icon);
            m_server_trust_icon->SetIcon(m_icon);
            //Layout();
        }
    }

    // Populate trusted CA list.
    for (std::list<winstd::cert_context>::const_iterator cert = m_cfg.m_trusted_root_ca.cbegin(), cert_end = m_cfg.m_trusted_root_ca.cend(); cert != cert_end; ++cert) {
        winstd::tstring name;
        if (CertGetNameString(*cert, CERT_NAME_SIMPLE_DISPLAY_TYPE, 0, NULL, name) > 0)
            m_root_ca->Append(wxString(name), new wxCertificateClientData(cert->duplicate()));
    }

    // Populate trusted server names.
    wxString str;
    for (std::list<std::string>::const_iterator name = m_cfg.m_server_names.cbegin(), name_end = m_cfg.m_server_names.cend(); name != name_end; ++name) {
        if (!str.IsEmpty()) str += wxT(';');
        str += *name;
    }
    m_server_names->SetValue(str);
}


//////////////////////////////////////////////////////////////////////
// wxCertificateClientData
//////////////////////////////////////////////////////////////////////

wxCertificateClientData::wxCertificateClientData(PCCERT_CONTEXT cert) : m_cert(cert)
{
}


wxCertificateClientData::~wxCertificateClientData()
{
    if (m_cert)
        CertFreeCertificateContext(m_cert);
}
