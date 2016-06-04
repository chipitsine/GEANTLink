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

#include "EAPTLS.h"
#include "../res/wxEAPTLS.h"

class wxEAPTLSConfigPanel;
class wxCERTCONTEXTClientData;

#pragma once

#include <wx/icon.h>


///
/// EAPTLS configuration panel
///
class wxEAPTLSConfigPanel : public wxEAPTLSConfigPanelBase
{
public:
    ///
    /// Constructs a configuration panel
    ///
    wxEAPTLSConfigPanel(eap::config_tls &cfg, wxWindow* parent);

protected:
    eap::config_tls &m_cfg;     ///< TLS configuration
    winstd::library m_certmgr;  ///< certmgr.dll resource library reference
    wxIcon m_icon;              ///< Panel icon
};


///
/// Helper class for auto-destroyable certificates used in wxWidget's item containers
///
class wxCertificateClientData : public wxClientData
{
public:
    ///
    /// Constructs client data object with existing handle
    ///
    wxCertificateClientData(PCCERT_CONTEXT m_cert);

    ///
    /// Releases certificate handle and destructs the object
    ///
    virtual ~wxCertificateClientData();

public:
    PCCERT_CONTEXT m_cert;  ///< Certificate
};
